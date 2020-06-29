import 'package:shared_preferences/shared_preferences.dart';

//Manage local shared prefs
class ClassSharedPref {
  static String keyBool = "isLoggedIn"; //is the user logged in ?
  var prefFile;
  ClassSharedPref() {
    getFile();
  }

  Future<void> getFile() async {
    prefFile = await SharedPreferences.getInstance();
  }

  Future<bool> getState() async {
    final getBool = prefFile.getBool(keyBool);
    if (getBool == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<void> setState() async {
    prefFile.setBool(keyBool, true);
  }
}
