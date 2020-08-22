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
  GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  List<Material> adBanner = [
    Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: ClassScreenConf.blockV * 10,
          width: ClassScreenConf.blockH * 50,
          color: Colors.blue[300],
        ),
      ),
    ),
    Material(
      child: InkWell(
        onTap: () {},
        child: Container(
          height: ClassScreenConf.blockV * 5,
          width: ClassScreenConf.blockH * 30,
          color: Colors.amber[300],
        ),
      ),
    ),
    Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: ClassScreenConf.blockV * 5,
          width: ClassScreenConf.blockH * 30,
          color: Colors.cyan[50],
        ),
      ),
    ),
    Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: ClassScreenConf.blockV * 10,
          width: ClassScreenConf.blockH * 50,
          color: Colors.green[200],
        ),
      ),
    ),
    Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: ClassScreenConf.blockV * 5,
          width: ClassScreenConf.blockH * 30,
          color: Colors.amber[500],
        ),
      ),
    ),
    Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: ClassScreenConf.blockV * 5,
          width: ClassScreenConf.blockH * 30,
          color: Colors.blue[600],
        ),
      ),
    ),
    Material(
      color: Colors.transparent,
      child: InkWell(
        splashColor: Colors.blue,
        onTap: () {},
        child: Container(
          height: ClassScreenConf.blockV * 5,
          width: ClassScreenConf.blockH * 30,
          color: Colors.red[100],
        ),
      ),
    ),
    Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: ClassScreenConf.blockV * 10,
          width: ClassScreenConf.blockH * 50,
          color: Colors.red[600],
        ),
      ),
    ),
  ];

  final TextEditingController searchBar = TextEditingController();

  Future<void> vendorDataInit() async {
    vendorDataList = await ClassFireStoreVendorDataRetrieve().vendorData();
    initListener();
  }

  void initListener() async {
    Future.delayed(Duration(seconds: 10), () {
      ClassFireStoreVendorDataRetrieve()
          .vendorStream
          .listen((QuerySnapshot event) {
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
          print("New Vendor List captured");
          int index =
              vendorDataList.indexWhere((vendor) => element.vid == vendor.vid);
          if (index != -1) {
            if (!element.onlineStatus)
              vendorListPop(vid: element.vid, index: index);
          } else {
            if (element.onlineStatus) vendorListInsert(element: element);
          }
        });
      });
    });
  }

  void searchButtonPressed(String value) {
    searchBar.text = "";
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
                child: Center(
                  child: Container(
                    width: widthMax - (widthMin * 10),
                    height: heightMin * 5,
                    color: Colors.white,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Card(
                        shadowColor: Colors.white,
                        color: Colors.transparent,
                        elevation: 8,
                        child: Container(
                          child: Stack(
                            children: [
                              Positioned(
                                left: widthMin * 2,
                                top: -heightMin * 1.4,
                                child: Container(
                                  width: widthMax - (widthMin * 10),
                                  child: TextField(
                                    controller: searchBar,
                                    cursorColor: colorDef,
                                    cursorWidth: widthMin * 0.5,
                                    onSubmitted: searchButtonPressed,
                                    style: TextStyle(
                                      fontSize: heightMin * 3,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                right: 0,
                                top: -heightMin * 1.2,
                                child: ClipOval(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      child: IconButton(
                                        onPressed: () =>
                                            searchButtonPressed(searchBar.text),
                                        icon: Icon(
                                          Icons.search,
                                          color: colorDef,
                                          size: heightMin * 4,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: heightMin * 16,
              child: Container(
                width: widthMax,
                height: heightMin * 14,
                child: ListView(
                  children: adBanner,
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ),
            Positioned(
              top: heightMin * 30,
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
      elevation: 2,
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

  void vendorListPop({String vid, int index}) {
    ClassVendorData removedItem = vendorDataList.removeAt(index);
    print("Popping");
    if (listKey.currentState != null) {
      listKey.currentState.removeItem(
        index,
        (context, animation) => buildCardElement(
          removedItem,
        ),
      );
    }
  }

  void vendorListInsert({ClassVendorData element}) {
    vendorDataList.insert(vendorDataList.length, element);
    if (listKey.currentState != null) {
      print("Inserting");
      listKey.currentState.insertItem(vendorDataList.length - 1);
      print(vendorDataList.length);
    }
  }
}
