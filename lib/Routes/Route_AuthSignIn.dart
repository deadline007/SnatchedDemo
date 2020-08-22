import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:snatched/Utilities/Class_AssetHolder.dart';
import 'package:snatched/Utilities/Class_ScreenConf.dart';
import 'package:snatched/Utilities/Class_FireBaseAuth.dart';
import 'package:snatched/Routes/Route_AuthSignUp.dart';

enum userId_error {
  NONE,
  NO_USERID_GIVEN,
}
enum password_error {
  NONE,
  NO_PASSWORD_GIVEN,
}

class RouteAuthSignIn extends StatelessWidget {
  final double widthMin = ClassScreenConf.blockH;
  final double widthMax = ClassScreenConf.hArea;
  final double heightMin = ClassScreenConf.blockV;
  final double heightMax = ClassScreenConf.vArea;
  final String fontDef = ClassAssetHolder.proximaLight;
  final Color colorDef = ClassAssetHolder.mainColor;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  Future<void> submit(BuildContext context) async {
    if (_email.text == "" && _password.text == "") {
      userIdErrorDisplay(context);
      passwordErrorDisplay(context);
      return;
    } else if (_password.text == "") {
      passwordErrorDisplay(context);
    } else if (_email.text == "") {
      userIdErrorDisplay(context);
    } else {
      final authSubmit = ClassFirebaseAuth(_email.text, _password.text);
      final submitResult = await authSubmit.signIn();
      if (submitResult == "NONE") {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/menu',
          (_) => false,
        );
      } else {
        final errorCode =
            Provider.of<ValueNotifier<String>>(context, listen: false);
        errorCode.value = submitResult;
      }
    }
  }

  void resetDisplay(BuildContext context) {
    final errorUserId =
        Provider.of<ValueNotifier<userId_error>>(context, listen: false);
    errorUserId.value = userId_error.NONE;
    final errorPassword =
        Provider.of<ValueNotifier<password_error>>(context, listen: false);
    errorPassword.value = password_error.NONE;
    final errorCode =
        Provider.of<ValueNotifier<String>>(context, listen: false);
    errorCode.value = "NONE";
  }

  void userIdErrorDisplay(BuildContext context) {
    final errorUserId =
        Provider.of<ValueNotifier<userId_error>>(context, listen: false);
    errorUserId.value = userId_error.NO_USERID_GIVEN;
  }

  void passwordErrorDisplay(BuildContext context) {
    final errorPassword =
        Provider.of<ValueNotifier<password_error>>(context, listen: false);
    errorPassword.value = password_error.NO_PASSWORD_GIVEN;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<ValueNotifier<userId_error>>(
            create: (context) => ValueNotifier<userId_error>(userId_error.NONE),
          ),
          ChangeNotifierProvider<ValueNotifier<password_error>>(
            create: (context) =>
                ValueNotifier<password_error>(password_error.NONE),
          ),
          ChangeNotifierProvider<ValueNotifier<String>>(
            create: (context) => ValueNotifier<String>("NONE"),
          )
        ],
        child: Builder(
          builder: (context) => buildContainer(
            context,
          ),
        ),
      ),
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      color: Colors.white,
      width: widthMax,
      height: heightMax,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: heightMin * 5,
            child: Container(
              height: heightMin * 10,
              width: widthMax - 44,
              child: Image.asset(
                ClassAssetHolder.logo,
              ),
            ),
          ),
          Positioned(
            top: heightMin * 20,
            child: Container(
              height: heightMin * 10,
              width: widthMax,
              child: Center(
                child: Text(
                  "Login",
                  style: TextStyle(
                    fontFamily: fontDef,
                    fontSize: widthMin * 10,
                    color: colorDef,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: heightMin * 26,
            child: Container(
              height: heightMin * 10,
              width: widthMax,
              child: Center(
                child: Consumer<ValueNotifier<String>>(
                  builder: (context, errorCode, _) {
                    if (errorCode.value == "NONE") {
                      return Container();
                    } else {
                      return Text(
                        errorCode.value,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: heightMin * 36,
            child: Container(
              width: widthMax,
              height: heightMin * 32,
              child: Padding(
                padding: EdgeInsets.only(
                  left: widthMin * 12,
                  right: widthMin * 12,
                ),
                child: Card(
                  color: Colors.white,
                  elevation: 0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: heightMin * 15,
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Email",
                                style: TextStyle(
                                  fontFamily: fontDef,
                                  fontSize: widthMin * 6,
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              child: TextField(
                                controller: _email,
                                cursorColor: colorDef,
                                enabled: true,
                                keyboardType: TextInputType.emailAddress,
                                autofocus: false,
                                toolbarOptions: ToolbarOptions(
                                  copy: true,
                                  paste: true,
                                ),
                                style: TextStyle(
                                  height: 1.5,
                                ),
                              ),
                            ),
                            Consumer<ValueNotifier<userId_error>>(
                              builder: (context, __, _) => userIdError(
                                context,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: heightMin * 15,
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Password",
                                style: TextStyle(
                                  fontFamily: fontDef,
                                  fontSize: widthMin * 6,
                                  color: Colors.grey[400],
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              child: TextField(
                                onSubmitted: (value) {
                                  resetDisplay(context);
                                  submit(context);
                                },
                                controller: _password,
                                obscureText: true,
                                cursorColor: colorDef,
                                enabled: true,
                                keyboardType: TextInputType.visiblePassword,
                                autofocus: false,
                                toolbarOptions: ToolbarOptions(
                                  copy: true,
                                  paste: true,
                                ),
                                style: TextStyle(
                                  height: 1.5,
                                ),
                              ),
                            ),
                            Container(
                              height: heightMin * 5,
                              child: Consumer<ValueNotifier<password_error>>(
                                builder: (context, __, _) => passwordError(
                                  context,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: heightMin * 66,
            child: Container(
              width: widthMax - 46,
              child: Align(
                alignment: Alignment.topRight,
                child: Material(
                  child: InkWell(
                    splashColor: colorDef,
                    onTap: () {},
                    child: Text(
                      "Forgot Password ?",
                      style: TextStyle(
                        fontFamily: fontDef,
                        fontSize: widthMin * 4.5,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: heightMin * 72,
            child: Container(
              width: widthMax,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    color: colorDef,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            resetDisplay(context);
                            submit(context);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: heightMin * 77,
            child: Container(
              height: heightMin * 10,
              width: widthMax,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      left: widthMax / 3,
                    ),
                    child: Text(
                      "Nay Account ?",
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RouteAuthSignUp(),
                        ),
                      );
                    },
                    child: Text(
                      "Sign Up!",
                      style: TextStyle(
                        color: colorDef,
                        fontSize: widthMin * 5,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget userIdError(BuildContext context) {
    final errorDisplay =
        Provider.of<ValueNotifier<userId_error>>(context, listen: false);
    if (errorDisplay.value == userId_error.NONE) {
      return Container();
    } else if (errorDisplay.value == userId_error.NO_USERID_GIVEN) {
      return Text(
        "Please enter an email.",
        style: TextStyle(
          color: Colors.red,
        ),
      );
    } else {
      return Container();
    }
  }

  Widget passwordError(BuildContext context) {
    final errorDisplay =
        Provider.of<ValueNotifier<password_error>>(context, listen: false);
    if (errorDisplay.value == password_error.NONE) {
      return Container();
    } else if (errorDisplay.value == password_error.NO_PASSWORD_GIVEN) {
      return Text(
        "Please enter a password.",
        style: TextStyle(
          color: Colors.red,
        ),
      );
    } else {
      return Container();
    }
  }
}
