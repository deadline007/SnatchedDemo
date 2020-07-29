import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:snatched/Routes/Route_BottomBar.dart';
import 'package:snatched/Routes/Route_OrderMenu.dart';
import 'package:snatched/Routes/Route_Profile.dart';

class RouteMainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ValueNotifier<currentPage>>(
      create: (_) => ValueNotifier<currentPage>(currentPage.MENU),
      child: Builder(
        builder: (context) => buildConsumer(context),
      ),
    );
  }

  Widget buildConsumer(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: RouteBottomBar().buildBottomBar(context),
      body: Consumer<ValueNotifier<currentPage>>(
        builder: (context, value, _) {
          switch (value.value) {
            case currentPage.MENU:
              print("Opening OrderMenu");
              return RouteOrderMenu().buildOrderMenu(context);
              break;
            /*  case currentPage.CART:
              break;
            case currentPage.ORDERS:
              break;
              break;
              */
            case currentPage.PROFILE:
              print("Opening profile");
              return RouteProfile().buildProfile(context);

              break;
            default:
              print("default ! Opening OrderMenu");
              return RouteOrderMenu().buildOrderMenu(context);
              break;
          }
        },
      ),
    );
  }
}
