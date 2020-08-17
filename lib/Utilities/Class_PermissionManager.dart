import 'package:permission_handler/permission_handler.dart';

class ClassPermissionManager {
  Future<void> askForPerms() async {
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();
    statuses.forEach((key, value) {
      print("${key.toString()} : ${value.toString()}");
    });
    return;
  }
}
