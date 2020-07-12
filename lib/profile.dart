import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class Profile extends StatefulWidget{
  @override
  _ProfileState  createState() => _ProfileState();
  }

class _ProfileState  extends State<Profile>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: new Stack(
            children: <Widget>[
        ClipPath(
        child: Container(color: Colors.black.withOpacity(0.8),
        ),

    clipper: getClipper(),
    ),
  Positioned(
  width: 350.0,
  top: MediaQuery.of(context).size.height / 5,
  child: Column(
  children: <Widget>[
  Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      SizedBox(width: 100),
      Container(
          width: 150.0,
      height: 150.0,
      decoration: BoxDecoration(
      color: Colors.red,
      image: DecorationImage(
      image: NetworkImage(
      'https://image.shutterstock.com/image-vector/user-icon-trendy-flat-style-600w-418179856.jpg'),
      fit: BoxFit.cover),
      borderRadius: BorderRadius.all(Radius.circular(75.0)),
      boxShadow: [
      BoxShadow(blurRadius: 7.0, color: Colors.black)
      ])),
   Spacer(),

      RawMaterialButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (_) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.all(
                        Radius.circular(10.0))),
                content: Builder(
                  builder: (context) {
                    var height = MediaQuery.of(context).size.height;
                    var width = MediaQuery.of(context).size.width;

                    return Container(
                      height: height/2,
                      width: width - 40,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 20.0),
                          Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Color.fromRGBO(255, 2, 102,100),
                                fontFamily: 'Montserrat'),
                          ),
                          SizedBox(height: 5.0),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(),
                          ),
//                          Text(
//                            'Ankit',
//                            style: TextStyle(
//                                fontSize: 20.0,
//                                color: Colors.grey,
//                                fontFamily: 'Montserrat'),
//                          ),
                          SizedBox(height: 5.0,width: 10,),
                          Text(
                            'Address',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 20.0,
                                color: Color.fromRGBO(255, 2, 102,100),
//  fontStyle: FontStyle.italic,
                                fontFamily: 'Montserrat'),
                          ),
                          SizedBox(height: 5.0),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(),
                          ),
//                          Text(
//                            'dxfgchgc \n jbjvhch',
//                            textAlign: TextAlign.left,
//                            style: TextStyle(
//                                fontSize: 17.0,
//                                color: Colors.grey,
////          fontStyle: FontStyle.italic,
//                                fontFamily: 'Montserrat'),
//                          ),
                          SizedBox(height: 25.0),
                          Text(
                            'Mobile Number',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 17.0,
                                color: Color.fromRGBO(255, 2, 102,100),
//          fontStyle: FontStyle.italic,
                                fontFamily: 'Montserrat'),
                          ),
                          SizedBox(height: 5.0),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextFormField(),
                          ),

//                      Navigator.of(context).pop();
                        ],
                      ),
                    );
                  },
                ),

              )
          );
        },
        elevation: 2.0,
        fillColor: Color.fromRGBO(255, 2, 102,100),
        child: Icon(

          Icons.edit,
          color: Colors.white,
          size: 25.0,
        ),
        shape: CircleBorder(),

      ),
    ],
  ),
  SizedBox(height: 20.0),
  Text(
  'Ankit',
  style: TextStyle(
  fontSize: 30.0,
  color: Color.fromRGBO(255, 2, 102,100),
  fontWeight: FontWeight.bold,
  fontFamily: 'Montserrat'),
  ),
  SizedBox(height: 20.0),
  Text(
  'Address',
  textAlign: TextAlign.left,
  style: TextStyle(
      fontSize: 17.0,
  color: Color.fromRGBO(255, 2, 102,100),
//  fontStyle: FontStyle.italic,
  fontFamily: 'Montserrat'),
  ),
  SizedBox(height: 5.0),
    Text(
      'dxfgchgc \n jbjvhch',
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: 17.0,
          color: Colors.grey,
//          fontStyle: FontStyle.italic,
          fontFamily: 'Montserrat'),
    ),
    SizedBox(height: 25.0),
    Text(
      'Mobile Number',
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: 17.0,
          color: Color.fromRGBO(255, 2, 102,100),
//          fontStyle: FontStyle.italic,
          fontFamily: 'Montserrat'),
    ),
    SizedBox(height: 5.0),
    Text(
      '7881818711',
      textAlign: TextAlign.left,
      style: TextStyle(
          fontSize: 17.0,
          color: Colors.grey,
//          fontStyle: FontStyle.italic,
          fontFamily: 'Montserrat'),
    ),

  SizedBox(height:150.0),
  Container(
  height: 30.0,
  width: 95.0,
  child: Material(
  borderRadius: BorderRadius.circular(20.0),
  shadowColor:Color.fromRGBO(255, 2, 102,100),
  color: Color.fromRGBO(255, 2, 102,100),
  elevation: 7.0,
  child: GestureDetector(
  onTap: () {Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => LoginPage()));},
  child: Center(
  child: Text(
  'Log out',
  style: TextStyle(color: Colors.white, fontFamily: 'Montserrat'),
  ),
  ),
  ),
  ))
  ],
  ))
  ],
  ));
}
}


class getClipper extends CustomClipper<Path> {
  @override

  Path getClip(Size size) {
    var path = new Path();

    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return true;
  }

}