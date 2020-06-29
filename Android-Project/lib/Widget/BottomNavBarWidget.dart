
import 'package:flutter/cupertino.dart';
import 'package:snatched/home.dart';
import 'package:flutter/material.dart';
import 'package:snatched/profile.dart';
import 'package:snatched/cart.dart';

class BottomNavBarWidget extends StatefulWidget {
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  int _currentIndex = 1;
  final tabs = [
    Profile(),
    Home(),
    FoodOrderPage(),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(
//        title: Text("Snatched"),
//      ),
      body:  Center(
        child: tabs.elementAt(_currentIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Color.fromRGBO(255, 2, 102, 100),
        currentIndex: _currentIndex,
        elevation: 20,
        showSelectedLabels: false,   // <-- HERE
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              title: Text("Profile")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu
              ),
              title: Text("Home")
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.restore,),
              title: Text("History")
          ),
        ],
        onTap:(index){
          setState(() {
            _currentIndex = index;
          });
        },

      ),
    );
      }
  }