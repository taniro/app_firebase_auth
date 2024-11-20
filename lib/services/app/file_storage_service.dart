import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class FileStorageService{

  Future<Directory> getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return Directory("/storage/emulated/0/Download");
    } else {
      return await getApplicationDocumentsDirectory();
    }
  }

  Future<File> writeBytesToFile(Uint8List data, String fileName) async {
    if (await Permission.storage.isDenied) {
      await Permission.storage.request();
    }
    // Obtém o diretório para salvar o arquivo
    final directory = await getDownloadsDirectory();

    // Cria o caminho completo para o arquivo
    final filePath = '${directory?.path}/$fileName';

    // Cria ou sobrescreve o arquivo com o conteúdo
    final file = File(filePath);

    // Escreve os Bytes no arquivo
    return file.writeAsBytes(data);
  }

  Future<File> writeStringToFile(String fileName, String content) async {
    if (await Permission.storage.isDenied) {
      await Permission.storage.request();
    }
    // Obtém o diretório para salvar o arquivo
    final directory = await getDownloadsDirectory();

    // Cria o caminho completo para o arquivo
    final filePath = '${directory?.path}/$fileName';

    // Cria ou sobrescreve o arquivo com o conteúdo
    final file = File(filePath);
    //Escreve os String no arquivo
    return file.writeAsString(content);
  }
}