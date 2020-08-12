import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:snatched/Routes/Route_BottomBar.dart';
import 'package:snatched/Routes/Route_OrderMenu.dart';
import 'package:snatched/Routes/Route_Profile.dart';
import 'package:snatched/Utilities/Class_AssetHolder.dart';
import 'package:snatched/Utilities/Class_LocalProfileImageStorage.dart';
import 'package:snatched/Utilities/Raw_ColorForTop.dart';

class RouteMainMenu extends StatelessWidget {

  
  Future<String> imagePathRetrieve() async {
    if (await ClassLocalProfileImageStorage().imageStatus) {
      File file = await ClassLocalProfileImageStorage().localFile;
      return file.path;
    } else {
      return ClassAssetHolder.defUser;
    }
  }

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
              return FutureBuilder(
                future: imagePathRetrieve(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return FutureBuilder(
                      future: colorForTop(snapshot.data),
                      builder: (_, snapshot2) {
                        if (snapshot2.connectionState == ConnectionState.done) {
                          return RouteProfile(snapshot.data, snapshot2.data)
                              .buildProfile(context);
                        } else {
                          return Container();
                        }
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              );

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
