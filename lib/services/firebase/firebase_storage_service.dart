import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  String generatePath(){
    // Caminho no Storage
    return 'uploads/${DateTime.now().millisecondsSinceEpoch}.png';
  }

  Future<void> uploadFile(File file, String remotePath) async {
    try {
      // Upload do arquivo
      await _firebaseStorage.ref(remotePath).putFile(file);
    } catch (e) {
      print('Erro no upload: $e');
    }
  }

  Future<String?> downloadFile(String storagePath) async {
    try {
      return await _firebaseStorage.ref(storagePath).getDownloadURL();
    } catch (e) {
      print('Erro ao obter URL: $e');
    }
    return null;
  }

  Future<void> deleteFile(String path) async {
    try {
      await FirebaseStorage.instance.ref(path).delete();
    } catch (e) {
      print('Erro ao deletar arquivo: $e');
    }
  }
}
