import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

class ClassLocalProfileImageStorage {
  Future<String> get _localPath async {
    final Directory dir = await getTemporaryDirectory();
    return dir.path;
  }

  Future<File> get localFile async {
    final String path = await _localPath;
    final File file = File("$path/ProfileImage.jpeg");
    return file;
  }

  Future<void> storeImage(Uint8List imageData) async {
    final File file = await localFile;
    await file.writeAsBytes(imageData, mode: FileMode.writeOnly).then(
          (value) => print("Image Stored"),
        );
    return;
  }

  Future<bool> get imageStatus async {
    final File file = await localFile;
    return file.exists();
  }
}
