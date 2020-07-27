import 'package:flutter/material.dart';

import 'package:snatched/Utilities/Class_ScreenConf.dart';
import 'package:snatched/Utilities/Class_AssetHolder.dart';

class RouteMenu extends StatefulWidget {
  @override
  _RouteMenuState createState() => _RouteMenuState();
}

class _RouteMenuState extends State<RouteMenu> {
  final double widthMin = ClassScreenConf.blockH;

  final double widthMax = ClassScreenConf.hArea;

  final double heightMin = ClassScreenConf.blockV;

  final double heightMax = ClassScreenConf.vArea;

  final String fontDef = ClassAssetHolder.proximaLight;

  final Color colorDef = ClassAssetHolder.mainColor;

  int currentBottomBarIndex = 0;

  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.fastfood),
      title: Text("Menu"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.history),
      title: Text("Orders"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      title: Text("Cart"),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.supervised_user_circle),
      title: Text("Profile"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: bottomNavItems,
        elevation: 5,
        backgroundColor: Colors.white70,
        iconSize: widthMin * 6,
        unselectedItemColor: Colors.grey[600],
        selectedItemColor: colorDef,
        showUnselectedLabels: true,
        currentIndex: currentBottomBarIndex,
        selectedFontSize: widthMin * 3,
        unselectedFontSize: widthMin * 3,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          currentBottomBarIndex = value;
          setState(() {});
        },
      ),
      body: Container(
        width: ClassScreenConf.hArea,
        height: ClassScreenConf.hArea,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: heightMin * 1,
              child: Container(
                alignment: Alignment.bottomLeft,
                width: widthMax,
                height: heightMin * 10,
                color: colorDef,
                child: SizedBox(
                  width: widthMax,
                  height: heightMin * 6,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        8,
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: <Widget>[
                        Text("Search  "),
                        Icon(Icons.search),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
