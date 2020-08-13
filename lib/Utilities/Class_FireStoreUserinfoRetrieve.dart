import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:snatched/Utilities/Class_FireBaseAuth.dart';

class ClassFireStoreUserinfoRetrieve {
  final userData = Firestore.instance.collection('userData');
  Future<String> retrieveName() async {
    final userId = await ClassFirebaseAuth.getCurrentUser();
    final DocumentSnapshot currentUser = await userData.document(userId).get();

    return "${await currentUser.data["First Name"]} ${await currentUser.data["Last Name"]} ";
  }

  Future<Map<int,String>> retrieveAddress() async {
    final userId = await ClassFirebaseAuth.getCurrentUser();
    final DocumentSnapshot currentUser = await userData.document(userId).get();
    final String address1=await currentUser.data["Address 1"];
    final String address2=await currentUser.data["Address 2"];
    final String address3=await currentUser.data["Address 3"];
    final Map<int,String> map={1:address1,2:address2,3:address3};
    return map;
  }

  Future<String> retrievePhone() async {
    final userId = await ClassFirebaseAuth.getCurrentUser();
    final DocumentSnapshot currentUser = await userData.document(userId).get();

    return "+91 ${await currentUser.data["Phone"]}";
  }
}
