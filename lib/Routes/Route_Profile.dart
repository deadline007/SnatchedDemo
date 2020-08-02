import 'package:flutter/material.dart';
import 'package:snatched/Utilities/Class_FireStoreUserinfoRetrieve.dart';

import 'package:snatched/Utilities/Class_ScreenConf.dart';
import 'package:snatched/Utilities/Class_AssetHolder.dart';

class RouteProfile {
  final double widthMin = ClassScreenConf.blockH;
  final double widthMax = ClassScreenConf.hArea;
  final double heightMin = ClassScreenConf.blockV;
  final double heightMax = ClassScreenConf.vArea;
  final String fontDef = ClassAssetHolder.proximaLight;
  final Color colorDef = ClassAssetHolder.mainColor;
  String userImage = ClassAssetHolder.defUser;
  Color topColor = Colors.white;

  final TextStyle subElementStyle = TextStyle(
      color: ClassAssetHolder.mainColor, fontSize: ClassScreenConf.blockV * 3);

  final EdgeInsets subElementPadding = EdgeInsets.only(
    left: ClassScreenConf.blockH * 8,
  );

  final TextStyle userDataStyle = TextStyle(
    fontFamily: ClassAssetHolder.proximaLight,
    fontWeight: FontWeight.w400,
    color: Colors.grey[800],
    fontSize: ClassScreenConf.blockV * 3,
  );

  Widget buildProfile(BuildContext context) {
    return Scaffold(
      body: Container(
        width: widthMax,
        height: heightMax,
        child: Stack(
          fit: StackFit.expand,
          overflow: Overflow.visible,
          alignment: Alignment.topLeft,
          children: <Widget>[
            Positioned(
              top: -heightMin * 30,
              left: -widthMin * 50,
              child: Container(
                height: heightMin * 70,
                width: widthMax * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
              ),
            ),
            Positioned(
              top: heightMin * 30,
              child: Container(
                width: widthMax,
                height: heightMin * 18,
                child: Center(
                  child: Container(
                    constraints: BoxConstraints.tight(
                      Size.fromRadius(
                        widthMin * 18,
                      ),
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.red,
                          Colors.amber,
                        ],
                      ),
                    ),
                    child: ClipOval(
                      clipBehavior: Clip.antiAlias,
                      child: Image.asset(
                        userImage,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: heightMin * 50,
              left: 0,
              child: Container(
                width: widthMax,
                height: heightMin * 5,
                child: Center(
                  child: Container(
                    child: FutureBuilder(
                      future: ClassFireStoreUserinfoRetrieve().retrieveName(),
                      builder: (_, snapshot) {
                        if (snapshot.connectionState == ConnectionState.none ||
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return Text("");
                        } else {
                          return Text(
                            snapshot.data,
                            style: TextStyle(
                              fontFamily: fontDef,
                              fontWeight: FontWeight.w900,
                              color: colorDef,
                              fontSize: heightMin * 4.6,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: heightMin * 60,
              child: Container(
                width: widthMax,
                height: heightMin * 18,
                child: Padding(
                  padding: subElementPadding,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Address",
                          style: subElementStyle,
                        ),
                      ),
                      Positioned(
                        top: heightMin * 5,
                        child: FutureBuilder(
                          future: ClassFireStoreUserinfoRetrieve()
                              .retrieveAddress(),
                          builder: (_, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.none ||
                                snapshot.connectionState ==
                                    ConnectionState.waiting) {
                              return Text("");
                            } else {
                              return Text(
                                snapshot.data,
                                style: userDataStyle,
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: heightMin * 77,
              child: Container(
                width: widthMax,
                height: heightMin * 12,
                child: Padding(
                  padding: subElementPadding,
                  child: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Phone", style: subElementStyle),
                      ),
                      Positioned(
                        top: heightMin * 5,
                        child: FutureBuilder(
                          future:
                              ClassFireStoreUserinfoRetrieve().retrievePhone(),
                          builder: (_, snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.none ||
                                snapshot.connectionState ==
                                    ConnectionState.waiting) {
                              return Text("");
                            } else {
                              return Text(
                                snapshot.data,
                                style: userDataStyle,
                              );
                            }
                          },
                        ),
                      ),
                    ],
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
