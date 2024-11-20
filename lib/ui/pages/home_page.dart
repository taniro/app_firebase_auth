import 'dart:io';

import 'package:app_firebase_auth/services/firebase/auth_service.dart';
import 'package:app_firebase_auth/services/app/file_storage_service.dart';
import 'package:app_firebase_auth/services/app/geolocator_service.dart';
import 'package:app_firebase_auth/ui/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //late Future<Position> position;
  //late GeoLocatorService geoLocatorService;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //geoLocatorService = Provider.of<GeoLocatorService>(context, listen: false);
    //position = geoLocatorService.determinePosition();
  }

  void saveFile(FileStorageService f) {
    String fileName = "example2.txt";
    String content = "Olá, este é o conteúdo do arquivo!!!";

    f.writeStringToFile(fileName, content).then((file) {
      print("Arquivo gravado com sucesso em ${file.path}");
    }).catchError((error) {
      print("Erro ao gravar o arquivo: $error");
    });
  }


  @override
  Widget build(BuildContext context)  {

    final authService = Provider.of<AuthService>(context, listen: false);
    //final permissionHandlerService = Provider.of<PermissionHandlerService>(context, listen: false);
    final fileStorageService = Provider.of<FileStorageService>(context, listen: false);


    //permissionHandlerService.requestPermissions([Permission.storage]);

    saveFile(fileStorageService);


    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*
            FutureBuilder(future: position, builder: (context, snapshot){
              if (snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }
              if (snapshot.hasError && !snapshot.hasData){
                return Text ("Error");
              }
              return Text(snapshot.data.toString());
            }),*/
            Text("Hello ! ${authService.getCurrentUserEmail()}"),
            CustomButton(height: 200, text: "Logout", onClick: ()=> {
                authService.signOut()
            })
          ],
        ),
      ),
    );
  }
}
