import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:after_layout/after_layout.dart';
import 'intro.dart';
import 'dart:async';
import 'login.dart';


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
        Duration(seconds: 3),
            () =>
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => LoginPage())));


//    var assetsImage = new AssetImage(
////        'assets/images/logo.png'); //<- Creates an object that fetches an image.
//    var image = new Image(
//        image: assetsImage,
//        height:300); //<- Creates a widget that displays an image.

    return MaterialApp(
      home: Scaffold(

        body: Container(
          decoration: new BoxDecoration(color: Colors.white),
          child: new Center(
            child: Image.asset("assets/images/logo.png"),
          ),
        ), //<- place where the image appears
      ),
    );
  }
}

