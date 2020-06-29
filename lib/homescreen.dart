import 'package:flutter/material.dart';
import 'package:snatched/profile.dart';
import "Widget/BottomNavBarWidget.dart";
import 'Widget/SearchWidget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(

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







