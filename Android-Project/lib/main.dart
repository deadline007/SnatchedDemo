import 'package:flutter/material.dart';

import 'package:snatched/Routes/Route_Splash.dart';

import 'package:snatched/Routes/Route_AuthSignIn.dart';
import 'package:snatched/Routes/Route_AuthSignUp.dart';
import 'package:snatched/Routes/Route_AppInfo.dart';
import 'package:snatched/Routes/Route_Menu.dart';

void main() {
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
        '/authSignIn': (context) => RouteAuthSignIn(),
        '/appInfo': (context) => RouteAppInfo(),
        '/menu': (context) => RouteMenu(),
        '/authSignUp' :(context) => RouteAuthSignUp(),
      },
    );
  }
}
