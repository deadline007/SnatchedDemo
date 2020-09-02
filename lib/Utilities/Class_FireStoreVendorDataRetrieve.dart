import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:snatched/Data/Class_VendorData.dart';
import 'package:snatched/Data/Class_VendorMenu.dart';

class ClassFireStoreVendorDataRetrieve {
  final userData = Firestore.instance.collection('vendorData');

  Future<List<ClassVendorData>> vendorData({bool filter = true}) async {
    QuerySnapshot vendorInfo = await userData.getDocuments();
    List<DocumentSnapshot> listOfDocs = vendorInfo.documents;
    List<ClassVendorData> listOfVendorData = List();

    listOfDocs.forEach(
      (element) async {
        if (filter) {
          if (element["OnlineStatus"]) {
            listOfVendorData.add(addData(element));
          }
        } else {
          listOfVendorData.add(addData(element));
        }
      },
    );
    return listOfVendorData;
  }

  ClassVendorData addData(DocumentSnapshot element) {
    return ClassVendorData(
      name: element["Name"],
      location: element["Location"],
      onlineStatus: element["OnlineStatus"],
      phone: element["Phone"],
      vid: element["VID"],
      stars: element["Stars"],
      type: element["Type"],
    );
  }

  Stream<QuerySnapshot> get vendorStream {
    return userData.snapshots();
  }

  Future<List<ClassVendorMenu>> vendorMenu(String vendorID) async {
    QuerySnapshot vendorInfo =
        await userData.document(vendorID).collection("menuItem").getDocuments();
    List<DocumentSnapshot> listOfItems = vendorInfo.documents;
    List<ClassVendorMenu> listOfVendorItems = List();

    listOfItems.forEach((element) {
      listOfVendorItems.add(
        ClassVendorMenu(
          itemImage: element["DisplayImage"],
          itemName: element["Name"],
          itemPrice: element["Price"],
          itemVotes: element["Votes"],
          itemTags: element["Tags"],
        ),
      );
    });
    return listOfVendorItems;
  }
}
