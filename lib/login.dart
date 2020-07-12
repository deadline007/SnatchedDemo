import 'package:flutter/material.dart';
import 'Widget/BottomNavBarWidget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'home.dart';

enum AuthMode { LOGIN, SINGUP }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // calculate the screen heigh
  double screenHeight;

  // Set intial mode to login
  AuthMode _authMode = AuthMode.LOGIN;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Center(
               child: Container(
                 child: Image.asset("assets/images/logo.png",
                   height: 200,
                   width: 200,


                ),
               ),
             ),
           ),
            _authMode == AuthMode.LOGIN
                ? loginCard(context)
                : singUpCard(context),

          ],
        ),
      ),
    );
  }



  Widget loginCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 4),
          padding: EdgeInsets.only(left: 10, right: 10),
//          child: Card(
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(10),
//            ),
//            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Login",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 2, 102, 100),
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Email", ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Password", ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      MaterialButton(
                        onPressed: () {
                        },
                        child: Text("Forgot Password ?",
                        ),

                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(),
                          ),

                          RawMaterialButton(
                            onPressed: () {Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => BottomNavBarWidget()));},
                            elevation: 2.0,
                            fillColor: Color.fromRGBO(255, 2, 102,100),
                            child: Icon(

                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 25.0,
                            ),
                            padding: EdgeInsets.all(10.0),
                            shape: CircleBorder(),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),

        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Text(
              "Don't have an account ?",
              style: TextStyle(color: Colors.grey),
            ),
            FlatButton(
              onPressed: () {
                setState(() {
                  _authMode = AuthMode.SINGUP;
                });
              },
              textColor: Color.fromRGBO(255, 2, 102,100),
              child: Text("Sign Up"),
            )
          ],
        ),
        FacebookGoogleLogin()
      ],
    );
  }

  Widget singUpCard(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(top: screenHeight / 6),
          padding: EdgeInsets.only(left: 10, right: 10),
//          child: Card(
//            shape: RoundedRectangleBorder(
//              borderRadius: BorderRadius.circular(10),
//            ),
//            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Color.fromRGBO(255, 2, 102,100),
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Name"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Email"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Password"),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: "Mobile Number"),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Password must be at least 8 characters and include a special character and number",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(),
                      ),
                      RawMaterialButton(
                        onPressed: () {Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => BottomNavBarWidget()));},
                        elevation: 2.0,
                        fillColor: Color.fromRGBO(255, 2, 102,100),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size: 25.0,
                        ),
                        padding: EdgeInsets.all(10.0),
                        shape: CircleBorder(),
                      ),

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
//            SizedBox(
//              height: 20,
//            ),
                      Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.grey),
                      ),
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            _authMode = AuthMode.LOGIN;
                          });
                        },
                        textColor: Color.fromRGBO(255, 2, 102, 100),
                        child: Text("Login"),
                      )
                    ],
                  ),
                  FacebookGoogleLogin()
//                  Align(
//                    alignment: Alignment.bottomCenter,
//                    child: FlatButton(
//                      child: Text(
//                        "Terms & Conditions",
//                        style: TextStyle(
//                          color: Colors.grey,
//                        ),
//                      ),
//                      onPressed: () {},
//                    ),
//                  ),
                ],
              ),
            ),
          ),
//        ),

      ],
    );
  }
}

class FacebookGoogleLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      gradient: new LinearGradient(
                          colors: [
                            Colors.black12,
                            Colors.black54,
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 1.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    width: 100.0,
                    height: 1.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Text(
                      "Or",
                      style: TextStyle(
                          color: Color(0xFF2c2b2b),
                          fontSize: 16.0,
                          fontFamily: "WorkSansMedium"),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: new LinearGradient(
                          colors: [
                            Colors.black54,
                            Colors.black12,
                          ],
                          begin: const FractionalOffset(0.0, 0.0),
                          end: const FractionalOffset(1.0, 1.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.clamp),
                    ),
                    width: 100.0,
                    height: 1.0,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 10.0, right: 40.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFf7418c),
                      ),
                      child: Icon(
                        FontAwesomeIcons.facebook,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: GestureDetector(
                    onTap: () => {},
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFFf7418c),
                      ),
                      child: new Icon(
                        FontAwesomeIcons.google,
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}