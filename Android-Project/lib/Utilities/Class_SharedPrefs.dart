import 'package:shared_preferences/shared_preferences.dart';

//Manage local shared prefs
class ClassSharedPref {
  static String key = "isSeen"; //is this the first time app is being opened
  Future<bool> getState() async {
    final prefFile = await SharedPreferences.getInstance();
    final getBool = prefFile.getBool(key);
    if (getBool == null) {
      prefFile.setBool(key, true);
      return false;
    } else {
      return true;
    }
  }
}
