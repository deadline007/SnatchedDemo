import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10,top: 40,right: 10,bottom: 5),
      child: TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
              borderSide: BorderSide(
                width: 3,
                color: Colors.pink,
              ),
          ),
          filled: true,
          prefixIcon: Icon(
            Icons.search,
            color: Color.fromRGBO(255, 2, 102, 100),
          ),
          fillColor: Colors.white,
          //suffixIcon: Icon(Icons.sort,color: Color(0xFFfb3132),),
          hintStyle: new TextStyle(color: Colors.grey, fontSize: 18),
          hintText: "What would your like to buy?",
        ),
      ),
    );
  }
}