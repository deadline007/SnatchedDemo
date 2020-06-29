import 'package:flutter/material.dart';
//import 'Widget/BottomNavBarWidget.dart';
import 'Widget/SearchWidget.dart';
class Home extends StatefulWidget{
  @override
  _HomeState createState() => _HomeState();

}

class _HomeState extends State<Home>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SingleChildScrollView(
        child: Column(
        children: <Widget>[
        SearchWidget(),

    ],
        ),
        ),
//      bottomNavigationBar: BottomNavBarWidget(),
    );
  }



}

