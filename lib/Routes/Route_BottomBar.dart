import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:snatched/Utilities/Class_ScreenConf.dart';
import 'package:snatched/Utilities/Class_AssetHolder.dart';

enum currentPage {
  PROFILE,
  MENU,
  ORDERS,
}

class RouteBottomBar {
  final double widthMin = ClassScreenConf.blockH;

  final double widthMax = ClassScreenConf.hArea;

  final double heightMin = ClassScreenConf.blockV;

  final double heightMax = ClassScreenConf.vArea;

  final Color colorDef = ClassAssetHolder.mainColor;
  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      title: Text("Profile"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.restaurant_menu),
      title: Text("Menu"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.restore),
      title: Text("Orders"),
    ),
  ];

  Widget buildBottomBar(BuildContext context) {
    return Consumer<ValueNotifier<currentPage>>(
      builder: (__, value, _) {
        return BottomNavigationBar(
          items: bottomNavItems,
          elevation: 20,
          
          backgroundColor: Colors.white,
          iconSize: widthMin * 8,
          unselectedItemColor: Colors.grey[800],
          
          selectedItemColor: colorDef,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          currentIndex: value.value.index,
          selectedFontSize: widthMin * 3.2,
          unselectedFontSize: widthMin * 3.2,
          type: BottomNavigationBarType.fixed,
          onTap: (val) {
            print(currentPage.values
                .where((element) => element.index == val)
                .first);
            value.value = currentPage.values
                .where((element) => element.index == val)
                .first;
          },
        );
      },
    );
  }
}
