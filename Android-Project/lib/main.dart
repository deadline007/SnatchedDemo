import 'package:flutter/material.dart';

import 'package:snatched/Routes/Route_Splash.dart';
import 'package:snatched/Utilities/Class_ScreenConf.dart';
import 'package:snatched/Routes/Route_Auth.dart';
import 'package:snatched/Routes/Route_AppInfo.dart';

void main() {
  ClassScreenConf(); //Storing screen config.
  runApp(
    new Main(),
  );
}

class Main extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => RouteSplash(),
        '/authRoute': (context) => RouteAuth(),
        '/appInfo': (context) => RouteAppInfo(),
      },
    );
  }
}
