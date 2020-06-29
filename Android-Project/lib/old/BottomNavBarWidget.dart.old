

import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatefulWidget {
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
//        navigateToScreens(index);
      });
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant_menu
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.restore),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Color.fromRGBO(255, 2, 102, 0),
          onTap: _onItemTapped,
        );
      }
  }