import 'dart:io';

import 'package:app_firebase_auth/model/Message.dart';
import 'package:app_firebase_auth/services/firebase/cloud_firestore_service.dart';
import 'package:app_firebase_auth/services/firebase/firebase_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DisplayPicturePage extends StatelessWidget {
  final String imagePath;

  const DisplayPicturePage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {

    CloudFiretoreService cloudFiretoreService= Provider.of<CloudFiretoreService>(context, listen: false);
    FirebaseStorageService firebaseStorageService= Provider.of<FirebaseStorageService>(context, listen: false);


    return Scaffold(
      appBar: AppBar(title: const Text('Display the Picture')),
      body: Image.file(File(imagePath)),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          String firebasePath = firebaseStorageService.generatePath();
          firebaseStorageService.uploadFile(File(imagePath), firebasePath);
          cloudFiretoreService.sendPictureMessage(firebasePath);
          Navigator.popUntil(context, (route) {
            // Verifica se o nome da rota é igual a "/"
            return route.isFirst; // Mantém apenas a primeira rota na pilha
          });
        },
        child: Icon(Icons.send),
      ),
    );
  }
}
