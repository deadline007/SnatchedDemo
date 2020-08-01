import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:snatched/Utilities/Class_FireBaseAuth.dart';

class ClassFireStoreUserinfoRetrieve {
  final userData = Firestore.instance.collection('userData');
  Future<String> retrieveName() async {
    final userId = await ClassFirebaseAuth.getCurrentUser();
    final DocumentSnapshot currentUser = await userData.document(userId).get();

    return "${await currentUser.data["First Name"]} ${await currentUser.data["Last Name"]} ";
  }

  Future<String> retrieveAddress() async {
    final userId = await ClassFirebaseAuth.getCurrentUser();
    final DocumentSnapshot currentUser = await userData.document(userId).get();

    return "${await currentUser.data["Address 1"]}\n${await currentUser.data["Address 2"]}\n${await currentUser.data["Address 3"]}";
  }

  Future<String> retrievePhone() async {
    final userId = await ClassFirebaseAuth.getCurrentUser();
    final DocumentSnapshot currentUser = await userData.document(userId).get();

    return "+91 ${await currentUser.data["Phone"]}";
  }
}
