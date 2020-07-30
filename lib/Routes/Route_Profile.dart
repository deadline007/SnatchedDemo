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
  Color topColor = Colors.white;

  RouteProfile() {}

  Widget buildProfile(BuildContext context) {
    return Scaffold(
      body: Container(
        width: widthMax,
        height: heightMax,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.pink[100],
              Colors.deepOrange[100],
            ],
            
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          overflow: Overflow.visible,
          alignment: Alignment.topLeft,
          children: <Widget>[
            Positioned(
              top: -heightMin * 20,
              left: -widthMin * 50,
              child: Container(
                height: heightMin * 70,
                width: widthMax * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                ),
              ),
            ),
            Positioned(
              top: heightMin * 35,
              child: Container(
                width: widthMax,
                height: heightMin * 18,
                child: Center(
                  child: Container(
                    width: widthMin * 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
