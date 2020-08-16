import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:snatched/Utilities/Class_SharedPrefs.dart';
import 'package:snatched/Utilities/Class_AssetHolder.dart';
import 'package:snatched/Utilities/Class_ScreenConf.dart';

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
              child: Container(
            width: ClassScreenConf.hArea,
            height: ClassScreenConf.vArea,
            decoration: BoxDecoration(
                image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                ClassAssetHolder.frontlogo,
              ),
            )),
          ) //<- place where the image appears
              ),
        ),
      ),
    );
  }
}
