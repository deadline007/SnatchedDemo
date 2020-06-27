
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Splash.dart';

void main() => runApp(new MyApp());
final bool debugShowCheckedModeBanner = true;


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      color: Colors.blue,
      debugShowCheckedModeBanner: false,
      home: new Splash(),

    );
  }
}

