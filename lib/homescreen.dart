import 'dart:html';

import 'package:flutter/material.dart';
import 'package:snatched/profile.dart';
import "Widget/BottomNavBarWidget.dart";
import 'Widget/SearchWidget.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Color(0xFFFAFAFA),
//        elevation: 0,
//        brightness: Brightness.light,
//        actions: <Widget>[
//
//        ],
//      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SearchWidget(),
            //RestroWidget(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavBarWidget(),
    );
  }
}







