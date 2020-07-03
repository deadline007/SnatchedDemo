import 'package:shared_preferences/shared_preferences.dart';

//Manage local shared prefs
class ClassSharedPref {
  static String keyBool = "isLoggedIn"; //is the user logged in ?

  Future<bool> getState() async {
    SharedPreferences prefFile = await SharedPreferences.getInstance();
    final bool getBool = prefFile.getBool(keyBool);
    if (getBool == null || !getBool) {
      setBool(false);
      return false;
    } else {
      return true;
    }
  }

  Future<void> setBool(bool state) async {
    SharedPreferences prefFile = await SharedPreferences.getInstance();
    await prefFile.setBool(keyBool, state);
  }
}
