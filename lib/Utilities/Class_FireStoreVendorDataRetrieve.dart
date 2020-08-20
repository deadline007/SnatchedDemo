import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:snatched/Data/Class_VendorData.dart';

class ClassFireStoreVendorDataRetrieve {
  final userData = Firestore.instance.collection('vendorData');

  Future<List<ClassVendorData>> vendorData() async {
    QuerySnapshot vendorInfo = await userData.getDocuments();
    List<DocumentSnapshot> listOfDocs = vendorInfo.documents;
    List<ClassVendorData> listOfVendorData = [];
    listOfDocs.forEach(
      (element) {
        listOfVendorData.add(
          ClassVendorData(
            name: element["Name"],
            location: element["Location"],
            onlineStatus: element["OnlineStatus"],
            phone: element["Phone"],
            vid: element["VID"],
          ),
        );
      },
    );
  }
}
