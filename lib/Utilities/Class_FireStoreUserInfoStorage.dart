import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snatched/Utilities/Class_FireBaseAuth.dart';

class ClassFireStoreUserInfoStorage {
  final String firstName, lastName, address1, address2, address3, email;
  final int phone;
  ClassFireStoreUserInfoStorage({
    @required this.firstName,
    this.lastName,
    @required this.address1,
    @required this.address2,
    this.address3,
    @required this.phone,
    @required this.email,
  });

  Future storeIntoFireStore() async {
    final userData = Firestore.instance.collection('userData');
    print("Storing into firebase...");
    await userData.document(this.email).setData({
      "First Name ": this.firstName,
      "Last Name ": this.lastName,
      "Address 1 ": this.address1,
      "Address 2 ": this.address2,
      "Address 3 ": this.address3,
      "Phone ": this.phone,
      "UID": await ClassFirebaseAuth.getCurrentUser(),
    });
  }
}
