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

  static Future<Map<CollectionReference, String>> get getDetails async {
    final userData = Firestore.instance.collection('userData');
    final uid = await ClassFirebaseAuth.getCurrentUser();
    Map<CollectionReference, String> map = {userData: uid};
    return map;
  }

  Future storeIntoFireStore() async {
    Map<CollectionReference, String> map = await getDetails;
    final userData = map.keys.first;
    final uid = map.values.first;
    print("Storing into firebase...");
    await userData.document(uid).setData({
      "First Name": this.firstName,
      "Last Name": this.lastName,
      "Address 1": this.address1,
      "Address 2": this.address2,
      "Address 3": this.address3,
      "Phone": this.phone,
      "email": this.email,
      "UID": uid,
    });
  }

  static Future storeName(String name) async {
    Map<CollectionReference, String> map = await getDetails;
    final userData = map.keys.first;
    final uid = map.values.first;
    List<String> nameSplit = name.split(" ");
    String firstName = nameSplit[0];
    String lastName = "";
    if (nameSplit.length > 1) {
      lastName = nameSplit[1];
    }
    print("Storing name");
    await userData.document(uid).setData({
      "First Name": firstName,
      "Last Name": lastName,
    }, merge: true);
  }

  static Future storeAddress1(String address) async {
    Map<CollectionReference, String> map = await getDetails;
    final userData = map.keys.first;
    final uid = map.values.first;
    await userData.document(uid).setData(
        ({
          "Address 1": address,
        }),
        merge: true);
  }

  static Future storeAddress2(String address) async {
    Map<CollectionReference, String> map = await getDetails;
    final userData = map.keys.first;
    final uid = map.values.first;
    await userData.document(uid).setData(
        ({
          "Address 2": address,
        }),
        merge: true);
  }

  static Future storeAddress3(String address) async {
    Map<CollectionReference, String> map = await getDetails;
    final userData = map.keys.first;
    final uid = map.values.first;
    await userData.document(uid).setData(
        ({
          "Address 3": address,
        }),
        merge: true);
  }

  static Future storePhone(int phone) async {
    Map<CollectionReference, String> map = await getDetails;
    final userData = map.keys.first;
    final uid = map.values.first;
    await userData.document(uid).setData(
        ({
          "Phone": phone,
        }),
        merge: true);
  }
}
