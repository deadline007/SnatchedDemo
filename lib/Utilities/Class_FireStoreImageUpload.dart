import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:snatched/Utilities/Class_FireBaseAuth.dart';

class FireStoreImageUpload {
  Future<StorageReference> imageReference() async {
    final StorageReference storageReference = FirebaseStorage.instance.ref().child(
        'userData/profileImages/${await ClassFirebaseAuth.getCurrentUser()}/ProfileImage.jpeg');
    return storageReference;
  }

  Future<String> uploadImage(Uint8List imageData) async {
    String fileURL;
    StorageReference storageReference = await imageReference();
    StorageUploadTask uploadTask = storageReference.putData(imageData);
    await uploadTask.onComplete.whenComplete(() async {
      print("User Image uploaded");
      fileURL = await getURL(storageReference);
    });

    return fileURL;
  }
  

  Future<String> getURL(StorageReference storageReference) async {
    String url;
    url = await storageReference.getDownloadURL();
    return url;
  }
}
