import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:snatched/Data/Class_VendorData.dart';

import 'package:snatched/Utilities/Class_ScreenConf.dart';
import 'package:snatched/Utilities/Class_AssetHolder.dart';
import 'package:snatched/Utilities/Class_FireStoreVendorDataRetrieve.dart';

class RouteOrderMenu extends StatefulWidget {
  @override
  _RouteOrderMenuState createState() => _RouteOrderMenuState();
}

class _RouteOrderMenuState extends State<RouteOrderMenu> {
  final double widthMin = ClassScreenConf.blockH;

  final double widthMax = ClassScreenConf.hArea;

  final double heightMin = ClassScreenConf.blockV;

  final double heightMax = ClassScreenConf.vArea;

  final String fontDef = ClassAssetHolder.proximaLight;

  final Color colorDef = ClassAssetHolder.mainColor;
  List<ClassVendorData> vendorDataList = List();
  GlobalKey<AnimatedListState> listKey;

  Future<void> vendorDataInit() async {
    vendorDataList = await ClassFireStoreVendorDataRetrieve().vendorData();
    initListener();
  }

  void initListener() async {
    Future.delayed(Duration(seconds: 10), () {
      ClassFireStoreVendorDataRetrieve().vendorStream.listen((event) {
        final List<ClassVendorData> newList =
            event.documents.map((DocumentSnapshot doc) {
          return ClassVendorData(
            name: doc["Name"],
            location: doc["Location"],
            onlineStatus: doc["OnlineStatus"],
            phone: doc["Phone"],
            vid: doc["VID"],
            stars: doc["Stars"],
            type: doc["Type"],
          );
        }).toList();
        newList.forEach((element) {
          if (!vendorDataList.contains(element)) {
            if (element.onlineStatus) {
              vendorListInsert(element: element, listKey: listKey);
            }
          } else {
            if (!element.onlineStatus) {
              vendorListPop(vid: element.vid, listKey: listKey);
            }
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: ClassScreenConf.hArea,
        height: ClassScreenConf.vArea,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: heightMin * 4,
              child: Container(
                width: widthMax,
                height: heightMin * 8,
                color: Colors.white,
                child: Center(
                  child: Container(
                    width: widthMax - (widthMin * 10),
                    height: heightMin * 5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Card(
                        elevation: 8,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: heightMin * 20,
              child: Container(
                height: heightMax,
                width: widthMax,
                child: FutureBuilder(
                    future: vendorDataInit(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done)
                        return Container();
                      return buildList(context);
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildList(BuildContext context) {
    return AnimatedList(
      key: listKey,
      initialItemCount: vendorDataList.length,
      itemBuilder: (context, index, animation) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            child: SizeTransition(
              axis: Axis.vertical,
              sizeFactor: animation,
              child: buildCardElement(vendorDataList[index]),
            ),
          ),
        );
      },
    );
  }

  Card buildCardElement(ClassVendorData vendorElement) {
    return Card(
      elevation: 0,
      child: Container(
        width: widthMax,
        height: heightMin * 10,
        child: Stack(
          children: [
            Positioned(
              left: widthMin * 5,
              top: heightMin * 1.6,
              child: Container(
                width: widthMin * 14,
                height: heightMin * 7,
                decoration: BoxDecoration(
                  color: Colors.teal[50],
                  borderRadius: BorderRadius.circular(
                    10,
                  ),
                ),
              ),
            ),
            Positioned(
              left: widthMin * 28,
              top: heightMin * 1.6,
              child: Text(
                vendorElement.name,
                style: TextStyle(
                  fontSize: heightMin * 2,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.6),
                ),
              ),
            ),
            Positioned(
              left: widthMin * 28,
              top: heightMin * 4.1,
              child: Text(
                vendorElement.type,
                style: TextStyle(
                  fontSize: heightMin * 1.6,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.withOpacity(0.6),
                ),
              ),
            ),
            Positioned(
              left: widthMin * 28,
              top: heightMin * 5.8,
              child: vendorElement.onlineStatus
                  ? Text(
                      "Open",
                      style: TextStyle(
                        fontSize: heightMin * 1.8,
                        fontWeight: FontWeight.w600,
                        color: Colors.green.withOpacity(0.6),
                      ),
                    )
                  : Text(
                      "Closed",
                      style: TextStyle(
                        fontSize: heightMin * 1.8,
                        fontWeight: FontWeight.w600,
                        color: Colors.red.withOpacity(0.6),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void vendorListPop({String vid, GlobalKey<AnimatedListState> listKey}) {
    int indexOfVid = vendorDataList.indexWhere((element) => element.vid == vid);
    ClassVendorData removedItem = vendorDataList.removeAt(indexOfVid);
    listKey.currentState.removeItem(
      indexOfVid,
      (context, animation) => buildCardElement(
        removedItem,
      ),
    );
  }

  void vendorListInsert(
      {ClassVendorData element, GlobalKey<AnimatedListState> listKey}) {
    print(vendorDataList.length);
    vendorDataList.insert(vendorDataList.length, element);
    print(listKey.currentState.toString());
    listKey.currentState.insertItem(vendorDataList.length - 1);
    print(vendorDataList.length);
  }
}
