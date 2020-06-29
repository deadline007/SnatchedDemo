import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:snatched/Utilities/Class_SharedPrefs.dart';
import 'package:snatched/Utilities/Class_AssetHolder.dart';
import 'package:snatched/Utilities/Class_ScreenConf.dart';
/*
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';
import 'dart:async';


class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new LoginPage()));
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (context) => new OnBoardingPage()));
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Timer(
        Duration(seconds: 5),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => LoginPage())));

    var assetsImage = new AssetImage(
        'assets/images/logo.png'); //<- Creates an object that fetches an image.
    var image = new Image(
        image: assetsImage,
        height: 300); //<- Creates a widget that displays an image.

    return 
  }
}
 */

class RouteSplash extends StatelessWidget {
  void onStart({BuildContext context}) {
    ClassScreenConf().init(context); //Storing screen config.
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    onStart(context: context);

    Future<void>.delayed(
      Duration(seconds: 3),
      () async {
        if (!await ClassSharedPref().getState()) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            '/appInfo',
            (_) => false,
          );
        }
      },
    );

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: new BoxDecoration(color: Colors.white),
          child: new Center(
            child: Image.asset(
              ClassAssetHolder.logo,
              height: 300,
            ), //<- place where the image appears
          ),
        ),
      ),
    );
  }
}
