import 'dart:html';

import 'package:flutter/material.dart';
import 'package:snatched/profile.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    profile(),
    Restro(),
    History(),


  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
//        title: const Text('BottomNavigationBar Sample'),
      ),
      body:
      Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu
            ),

            title: Text('Business'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restore),
            title: Text('School'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(255, 2, 102, 0),
        onTap: _onItemTapped,
      ),
    );
  }
}





