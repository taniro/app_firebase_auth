import 'package:app_firebase_auth/services/app/file_storage_service.dart';
import 'package:app_firebase_auth/ui/pages/display_picture_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TakePicturePage extends StatefulWidget {
  const TakePicturePage({
    super.key
  });

  @override
  TakePicturePageState createState() => TakePicturePageState();
}

class TakePicturePageState extends State<TakePicturePage> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late CameraDescription camera;

  Future<void> _initializeCamera() async {
    try {
      // Obtém as câmeras disponíveis
      final cameras = await availableCameras();
      camera = cameras.last; // Seleciona a primeira câmera

      // Inicializa o controlador da câmera
      _controller = CameraController(
        camera,
        ResolutionPreset.medium,
      );

      // Inicializa o controlador
      await _controller.initialize();
    } catch (e) {
      print('Erro ao inicializar a câmera: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeControllerFuture = _initializeCamera();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fileStorageService = Provider.of<FileStorageService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Take a Picture')),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // Se o Future foi concluído, mostra o preview da câmera
            return CameraPreview(_controller);
          } else if (snapshot.hasError) {
            // Mostra mensagem de erro, se ocorrer algum problema
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else {
            // Enquanto carrega, mostra o indicador de progresso
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            // Aguarda a inicialização
            await _initializeControllerFuture;

            // Tira a foto e obtém o caminho do arquivo salvo
            final image = await _controller.takePicture();

            if (!mounted) return;

            fileStorageService.writeBytesToFile (await image.readAsBytes(), image.name);

            // Navega para a próxima tela para exibir a foto
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DisplayPicturePage(imagePath: image.path),
              ),
            );
          } catch (e) {
            print('Erro ao tirar a foto: $e');
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}