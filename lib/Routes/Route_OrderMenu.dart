import 'package:flutter/material.dart';

import 'package:snatched/Utilities/Class_ScreenConf.dart';
import 'package:snatched/Utilities/Class_AssetHolder.dart';

class RouteOrderMenu {
  final double widthMin = ClassScreenConf.blockH;

  final double widthMax = ClassScreenConf.hArea;

  final double heightMin = ClassScreenConf.blockV;

  final double heightMax = ClassScreenConf.vArea;

  final String fontDef = ClassAssetHolder.proximaLight;

  final Color colorDef = ClassAssetHolder.mainColor;

  Widget buildOrderMenu(BuildContext context) {
    return Scaffold(
      body: Container(
        width: ClassScreenConf.hArea,
        height: ClassScreenConf.vArea,
        color: Colors.blue,
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
