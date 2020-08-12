import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:snatched/Utilities/Class_FireBaseAuth.dart';

class ClassFireStoreImageRetrieve {
  Future<StorageReference> _getRef() async {
    StorageReference storageReference = FirebaseStorage.instance.ref().child(
        'userData/profileImages/${await ClassFirebaseAuth.getCurrentUser()}/ProfileImage.jpeg');
    return storageReference;
  }

  Future<Uint8List> getImage() async {
    StorageReference storageReference= await _getRef();
    Uint8List imageData=await storageReference.getData(5000000);
    return imageData;
  }

  Future<bool> imageStatus() async{
    bool state=true;
    StorageReference storageReference=await _getRef();
    await storageReference.getDownloadURL().catchError(()=> state=false);
    return state;
  }
}
