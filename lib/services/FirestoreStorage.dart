import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart';

abstract class StorageBase {
  UploadTask? uploadFile({required String filePath, required String fileName});
}

class MyStorage implements StorageBase {
  static FirebaseApp _app = Firebase.apps.first;

  firebase_storage.FirebaseStorage storageInstance =
      firebase_storage.FirebaseStorage.instanceFor(app: _app);
  String uploadDestiantion = "cakes/images/";

  UploadTask? uploadFile({required String filePath, required String fileName}) {
    File file = File(filePath);

    try {
      print("fileName : " + fileName);
      print("filePath : " + filePath);
      final ref = storageInstance.ref(uploadDestiantion + fileName);
      final snapshot = ref.putFile(file);
      // return snapshot.ref.getDownloadURL();
      return snapshot;
    } on firebase_core.FirebaseException catch (e) {
      // e.g, e.code == 'canceled'
      print("error : $e");
    }
  }
}
