import 'package:flutter/material.dart';

import 'package:snatched/Utilities/Class_ScreenConf.dart';
import 'package:snatched/Utilities/Class_AssetHolder.dart';

class RouteProfile extends StatelessWidget {
  final double widthMin = ClassScreenConf.blockH;
  final double widthMax = ClassScreenConf.hArea;
  final double heightMin = ClassScreenConf.blockV;
  final double heightMax = ClassScreenConf.vArea;
  final String fontDef = ClassAssetHolder.proximaLight;
  final Color colorDef = ClassAssetHolder.mainColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        overflow: Overflow.clip,
        alignment: Alignment.topLeft,
        children: <Widget>[],
      ),
    );
  }
}
