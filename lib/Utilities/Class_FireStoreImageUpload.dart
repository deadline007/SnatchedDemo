import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:snatched/Utilities/Class_FireBaseAuth.dart';

class FireStoreImageUpload {
  final StorageReference storageReference = FirebaseStorage.instance
      .ref()
      .child('userData/profileImages/${ClassFirebaseAuth.getCurrentUser()}');
  String fileURL;

  Future<String> uploadImage(Uint8List image) async {
    StorageUploadTask uploadTask = storageReference.putData(image);
    await uploadTask.onComplete;
    print("User Image uploaded");

    await storageReference
        .getDownloadURL()
        .then((value) => this.fileURL = value);
    return fileURL;
  }
}
