import 'package:flutter/material.dart';
import 'package:snatched/Data/Class_VendorData.dart';
import 'package:snatched/Utilities/Class_FireStoreVendorDataRetrieve.dart';
import 'package:snatched/Data/Class_VendorMenu.dart';

class RouteVendorMenu extends StatefulWidget {
  final ClassVendorData vendorData;
  RouteVendorMenu({Key key, this.vendorData}) : super(key: key);
  @override
  _RouteVendorMenuState createState() => _RouteVendorMenuState();
}

class _RouteVendorMenuState extends State<RouteVendorMenu> {
  List<ClassVendorMenu> menuItems = [];
  Future<void> getMenu() async {
    menuItems = await ClassFireStoreVendorDataRetrieve()
        .vendorMenu(widget.vendorData.vid);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
