import 'package:flutter/material.dart';

import 'package:snatched/Utilities/Class_ScreenConf.dart';
import 'package:snatched/Utilities/Class_AssetHolder.dart';

class RouteProfile {
  final double widthMin = ClassScreenConf.blockH;
  final double widthMax = ClassScreenConf.hArea;
  final double heightMin = ClassScreenConf.blockV;
  final double heightMax = ClassScreenConf.vArea;
  final String fontDef = ClassAssetHolder.proximaLight;
  final Color colorDef = ClassAssetHolder.mainColor;

  Widget buildProfile(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        overflow: Overflow.visible,
        alignment: Alignment.topLeft,
        children: <Widget>[
          Positioned(
            top: 0,
            child: Container(
              height: heightMin * 30,
              width: widthMax,
              alignment: Alignment.topLeft,
              color: Colors.red,
            ),
          )
        ],
      ),
    );
  }
}
