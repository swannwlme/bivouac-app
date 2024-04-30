import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class DataStorage {
  final storage = FirebaseStorage.instance;

  Future<String> uploadFile(String path, File file) async {
    try {
      await storage.ref(path).putFile(file);
      return await storage.ref(path).getDownloadURL();
    } catch (e) {
      print(e.toString());
      return "";
    }
  }

  Future<String> getDownloadURL(String fileName) async {
    try {
      return await FirebaseStorage.instance
          .ref()
          .child(fileName)
          .getDownloadURL();
    } catch (e) {
      return "";
    }
  }
}

