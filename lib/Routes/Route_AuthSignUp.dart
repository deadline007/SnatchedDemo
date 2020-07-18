import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:snatched/Utilities/Class_AssetHolder.dart';
import 'package:snatched/Utilities/Class_ScreenConf.dart';
import 'package:snatched/Utilities/Class_FireBaseAuth.dart';
import 'package:snatched/Utilities/Class_SignUpSliderTheme.dart';

enum userId_error {
  NONE,
  NO_USERID_GIVEN,
}
enum password_error {
  NONE,
  NO_PASSWORD_GIVEN,
}
enum signUpState {
  NAME,
  MOBILE,
  ADDRESS,
  EMAIL,
  PASSWORD,
}

class RouteAuthSignUp extends StatefulWidget {
  @override
  _RouteAuthSignUpState createState() => _RouteAuthSignUpState();
}

class _RouteAuthSignUpState extends State<RouteAuthSignUp> {
  final double widthMin = ClassScreenConf.blockH;

  final double widthMax = ClassScreenConf.hArea;

  final double heightMin = ClassScreenConf.blockV;

  final double heightMax = ClassScreenConf.vArea;

  final String fontDef = ClassAssetHolder.proximaLight;

  final Color colorDef = ClassAssetHolder.mainColor;

  final Color colorDef2 = Colors.grey[400];

  final TextEditingController _email = TextEditingController();

  final TextEditingController _password = TextEditingController();

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();

  final TextEditingController _phone = TextEditingController();

  final TextEditingController _addressLine1 = TextEditingController();

  final TextEditingController _addressLine2 = TextEditingController();

  final TextEditingController _addressLine3 = TextEditingController();

  TextStyle textStyleDef;

  _RouteAuthSignUpState() {
    textStyleDef = TextStyle(
      fontFamily: fontDef,
      fontSize: widthMin * 6,
      color: colorDef2,
      fontWeight: FontWeight.bold,
    );
  }

  //slider Widget Data
  final int sliderMin = 0;
  final int sliderMax = 2;
  final bool fullSliderWidth = false;
  final double sliderHeight = ClassScreenConf.blockV * 5;
  double sliderValue = 0;

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
      final submitResult = await authSubmit.signUp();
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
            create: (_) => ValueNotifier<userId_error>(userId_error.NONE),
          ),
          ChangeNotifierProvider<ValueNotifier<password_error>>(
            create: (_) => ValueNotifier<password_error>(password_error.NONE),
          ),
          ChangeNotifierProvider<ValueNotifier<String>>(
            create: (_) => ValueNotifier<String>("NONE"),
          ),
          ChangeNotifierProvider<ValueNotifier<signUpState>>(
            create: (_) => ValueNotifier<signUpState>(
              signUpState.NAME,
            ),
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
            child: Row(
              children: <Widget>[
                Container(
                  child: Material(
                    child: InkWell(
                      child: IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
                Container(
                  height: heightMin * 10,
                  width: widthMax - 100,
                  child: Image.asset(
                    ClassAssetHolder.logo,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: heightMin * 16,
            child: Container(
              height: heightMin * 10,
              width: widthMax,
              child: Center(
                child: Text(
                  "Register",
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
            top: heightMin * 24,
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
            top: heightMin * 32,
            child: Container(
              width: widthMax,
              height: heightMin * 35,
              child: Padding(
                padding: EdgeInsets.only(
                  left: widthMin * 10,
                  right: widthMin * 10,
                ),
                child: Card(
                  color: Colors.white,
                  elevation: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          5,
                        ),
                      ),
                      border: Border.all(
                        color: Colors.black.withOpacity(
                          0.2,
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: widthMin * 3,
                        top: heightMin * 3,
                        right: widthMin * 3,
                      ),
                      child: Consumer<ValueNotifier<signUpState>>(
                        builder: (context, value, _) {
                          return signUpBuild(context, value.value);
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: heightMin * 66,
            child: Container(
              width: widthMax,
              height: heightMin * 4,
              child: Center(
                child: SizedBox(
                  width: widthMin * 38,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          sliderHeight * 0.3,
                        ),
                      ),
                    ),
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Colors.transparent,
                        inactiveTrackColor: Colors.transparent,
                        trackHeight: heightMin * 4,
                        thumbShape: ClassSignUpSliderTheme(
                          thumbRadius: heightMin * 4 * 0.4,
                          min: sliderMin,
                          max: sliderMax,
                        ),
                        overlayColor: Colors.white.withOpacity(0.4),
                        activeTickMarkColor: Colors.orange[700],
                        inactiveTickMarkColor: Colors.orange[400],
                      ),
                      child: Slider(
                        min: sliderMin.toDouble(),
                        max: sliderMax.toDouble(),
                        divisions: 2,
                        value: sliderValue,
                        onChanged: (value) {
                          print("sliderval : $value");
                          setState(
                            () {
                              sliderValue = value;
                            },
                          );
                          final temp = Provider.of<ValueNotifier<signUpState>>(
                              context,
                              listen: false);
                          if (value == 0) {
                            temp.value = signUpState.NAME;
                          } else if (value == 1) {
                            temp.value = signUpState.ADDRESS;
                          } else {
                            temp.value = signUpState.EMAIL;
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: heightMin * 78,
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

  Widget signUpBuild(BuildContext context, signUpState state) {
    print(state.toString());
    if (state == signUpState.EMAIL || state == signUpState.PASSWORD) {
      return emailPwd();
    } else if (state == signUpState.NAME || state == signUpState.MOBILE) {
      return nameMobile();
    } else if (state == signUpState.ADDRESS) {
      return address();
    } else {
      return emailPwd();
    }
  }

  Widget nameMobile() {
    return Column(
      children: <Widget>[
        Container(
          height: heightMin * 15,
          child: Row(
            children: <Widget>[
              Container(
                width: widthMin * 30,
                child: Column(
                  children: <Widget>[
                    Text(
                      "First name",
                      style: textStyleDef,
                    ),
                    TextField(
                      controller: _firstName,
                      cursorColor: colorDef,
                      enabled: true,
                      keyboardType: TextInputType.text,
                      autofocus: false,
                      toolbarOptions: ToolbarOptions(
                        copy: true,
                        paste: true,
                      ),
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: widthMin * 8,
                ),
                child: Container(
                  width: widthMin * 32,
                  child: Column(
                    children: <Widget>[
                      Text(
                        "Last Name",
                        style: textStyleDef,
                      ),
                      TextField(
                        controller: _lastName,
                        cursorColor: colorDef,
                        enabled: true,
                        keyboardType: TextInputType.text,
                        autofocus: false,
                        toolbarOptions: ToolbarOptions(
                          copy: true,
                          paste: true,
                        ),
                        style: TextStyle(
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: widthMin * 50,
          child: Column(
            children: <Widget>[
              Text(
                "Phone Number",
                style: textStyleDef,
              ),
              TextField(
                controller: _firstName,
                cursorColor: colorDef,
                enabled: true,
                keyboardType: TextInputType.phone,
                autofocus: false,
                toolbarOptions: ToolbarOptions(
                  copy: true,
                  paste: true,
                ),
                style: TextStyle(
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget address() {
    return Container(
      width: widthMin * 60,
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Address Line 1",
              style: textStyleDef,
            ),
          ),
          Positioned(
            top: heightMin * 2,
            child: Container(
              width: widthMin * 70,
              child: TextField(
                textAlign: TextAlign.left,
                controller: _addressLine1,
                cursorColor: colorDef,
                enabled: true,
                keyboardType: TextInputType.text,
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
          ),
          Positioned(
            top: heightMin * 10,
            left: 0,
            child: Text(
              "Address Line 2",
              style: textStyleDef,
            ),
          ),
          Positioned(
            top: heightMin * 12,
            child: Container(
              width: widthMin * 70,
              child: TextField(
                textAlign: TextAlign.left,
                controller: _addressLine2,
                cursorColor: colorDef,
                enabled: true,
                keyboardType: TextInputType.text,
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
          ),
          Positioned(
            top: heightMin * 20,
            left: 0,
            child: Text(
              "Address Line 3",
              style: textStyleDef,
            ),
          ),
          Positioned(
            top: heightMin * 21,
            child: Container(
              width: widthMin * 70,
              child: TextField(
                textAlign: TextAlign.left,
                controller: _addressLine3,
                cursorColor: colorDef,
                enabled: true,
                keyboardType: TextInputType.text,
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
          ),
        ],
      ),
    );
  }

  Widget emailPwd() {
    return Column(
      children: <Widget>[
        Container(
          height: heightMin * 15,
          child: Column(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Email",
                  style: textStyleDef,
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
                  style: textStyleDef,
                ),
              ),
              Container(
                child: TextField(
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
    );
  }
}
