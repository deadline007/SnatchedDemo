import 'package:flutter/material.dart';

import 'package:snatched/Utilities/Class_AssetHolder.dart';
import 'package:snatched/Utilities/Class_ScreenConf.dart';

class RouteAuth extends StatelessWidget {
  final double widthMin = ClassScreenConf.blockH;
  final double widthMax = ClassScreenConf.hArea;
  final double heightMin = ClassScreenConf.blockV;
  final double heightMax = ClassScreenConf.vArea;
  final String fontDef = ClassAssetHolder.proximaLight;
  final Color colorDef = ClassAssetHolder.mainColor;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<void> submit() async {
    if (_email != null && _password != null) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        width: widthMax,
        height: heightMax,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: heightMin * 5,
              child: Container(
                height: heightMin * 10,
                width: widthMax - 44,
                child: Image.asset(
                  ClassAssetHolder.logo,
                ),
              ),
            ),
            Positioned(
              top: heightMin * 20,
              child: Container(
                height: heightMin * 10,
                width: widthMax,
                child: Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontFamily: fontDef,
                      fontSize: widthMin * 10,
                      color: colorDef,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: heightMin * 36,
              child: Container(
                width: widthMax,
                height: heightMin * 32,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: widthMin * 12,
                    right: widthMin * 12,
                  ),
                  child: Card(
                    color: Colors.white,
                    elevation: 0,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: heightMin * 15,
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Email",
                                  style: TextStyle(
                                    fontFamily: fontDef,
                                    fontSize: widthMin * 6,
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                child: TextField(
                                  controller: _email,
                                  cursorColor: colorDef,
                                  enabled: true,
                                  keyboardType: TextInputType.emailAddress,
                                  autofocus: false,
                                  toolbarOptions: ToolbarOptions(
                                    copy: true,
                                    paste: true,
                                  ),
                                  style: TextStyle(
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: heightMin * 15,
                          child: Column(
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Password",
                                  style: TextStyle(
                                    fontFamily: fontDef,
                                    fontSize: widthMin * 6,
                                    color: Colors.grey[400],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                child: TextField(
                                  controller: _password,
                                  obscureText: true,
                                  cursorColor: colorDef,
                                  enabled: true,
                                  keyboardType: TextInputType.visiblePassword,
                                  autofocus: false,
                                  toolbarOptions: ToolbarOptions(
                                    copy: true,
                                    paste: true,
                                  ),
                                  style: TextStyle(
                                    height: 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: heightMin * 64,
              child: Container(
                width: widthMax - 46,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Material(
                    child: InkWell(
                      splashColor: colorDef,
                      onTap: () {},
                      child: Text(
                        "Forgot Password ?",
                        style: TextStyle(
                          fontFamily: fontDef,
                          fontSize: widthMin * 4.5,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: heightMin * 70,
              child: Container(
                width: widthMax,
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      color: colorDef,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                        ),
                        onPressed: () {},
                      ),
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
