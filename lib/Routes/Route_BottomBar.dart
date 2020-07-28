import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:snatched/Utilities/Class_ScreenConf.dart';
import 'package:snatched/Utilities/Class_AssetHolder.dart';

enum currentPage {
  MENU,
  ORDERS,
  CART,
  PROFILE,
}

class RouteBottomBar extends StatelessWidget {
  final double widthMin = ClassScreenConf.blockH;

  final double widthMax = ClassScreenConf.hArea;

  final double heightMin = ClassScreenConf.blockV;

  final double heightMax = ClassScreenConf.vArea;

  final Color colorDef = ClassAssetHolder.mainColor;
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
    return ChangeNotifierProvider<ValueNotifier<currentPage>>(
      create: (_) => ValueNotifier<currentPage>(currentPage.MENU),
      child: buildConsumer(),
    );
  }

  Widget buildConsumer() {
    return Consumer<ValueNotifier<currentPage>>(
      builder: (context, value, _) {
        return Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            items: bottomNavItems,
            elevation: 5,
            backgroundColor: Colors.white70,
            iconSize: widthMin * 6,
            unselectedItemColor: Colors.grey[600],
            selectedItemColor: colorDef,
            showUnselectedLabels: true,
            currentIndex: value.value.index,
            selectedFontSize: widthMin * 3,
            unselectedFontSize: widthMin * 3,
            type: BottomNavigationBarType.fixed,
            onTap: (val) {
              value.value = currentPage.values
                  .where((element) => element.index == val)
                  .elementAt(0);
            },
          ),
          body: Consumer<ValueNotifier<currentPage>>(
            builder: (context, value, _) {
              switch (value.value) {
                case currentPage.MENU:
                  break;
                default:
              }
            },
          ),
        );
      },
    );
  }
}
