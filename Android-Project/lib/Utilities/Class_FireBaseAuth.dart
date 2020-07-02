import 'package:firebase_auth/firebase_auth.dart';

class ClassFirebaseAuth {
  final String _userId;
  final String _password;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  ClassFirebaseAuth(this._userId, this._password);

  Future<String> signIn() async {
    final AuthResult result = await _auth.signInWithEmailAndPassword(
        email: _userId, password: _password);
    final FirebaseUser user = result.user;
    return user.uid;
  }

  Future<String> signUp() async {
    final AuthResult result = await _auth.createUserWithEmailAndPassword(
        email: _userId, password: _password);
    final FirebaseUser user = result.user;
    return user.uid;
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
    return user.isEmailVerified;
  }

  Future<FirebaseUser> getCurrentUser() async {
    final FirebaseUser user = await _auth.currentUser();
    return user;
  }
}
