import 'package:firebase_auth/firebase_auth.dart';

class ClassFirebaseAuth {
  final String _userId;
  final String _password;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  ClassFirebaseAuth(this._userId, this._password);

  Future<String> signIn() async {
    String errorMessage = "NONE";
    FirebaseUser user;
    try {
      final AuthResult result = await _auth.signInWithEmailAndPassword(
          email: _userId, password: _password);
      user = result.user;
    } catch (error) {
      errorMessage = error.code.toString();
    }
    if (errorMessage == "NONE") {
      print(user.uid);
    }
    return errorMessage;
  }

  Future<String> signUp() async {
    String errorMessage = "NONE";
    FirebaseUser user;
    try {
      final AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: _userId, password: _password);
      user = result.user;
    } catch (error) {
      errorMessage = error.code.toString();
    }
    if (errorMessage == "NONE") {
      print(user.uid);
    }

    return errorMessage;
  }

  Future<void> singOut() async {
    await _auth.signOut();
  }

  Future<void> sendEmailConf() async {
    final FirebaseUser user = await _auth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> verificationStatus() async {
    final FirebaseUser user = await _auth.currentUser();
    print("Signed In , any error : ${await signIn()}");
    print("Current user email: ${user.email}");
    if (user.isEmailVerified) {
      print("Verified : true");
      return true;
    } else {
      print("Verified : false");
      return false;
    }
  }

  static Future<String> getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    return user.uid;
  }
}
