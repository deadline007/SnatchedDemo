import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snatched/Utilities/Class_FireStoreUserinfoRetrieve.dart';

import 'package:provider/provider.dart';

import 'package:snatched/Utilities/Class_ScreenConf.dart';
import 'package:snatched/Utilities/Class_AssetHolder.dart';
import 'package:snatched/Utilities/Class_primaryColorGen.dart';
import 'package:snatched/Utilities/Class_FireStoreImageUpload.dart';

enum editState {
  NONE,
  EDITING,
}

class RouteProfile {
  final double widthMin = ClassScreenConf.blockH;
  final double widthMax = ClassScreenConf.hArea;
  final double heightMin = ClassScreenConf.blockV;
  final double heightMax = ClassScreenConf.vArea;
  final String fontDef = ClassAssetHolder.proximaLight;
  final Color colorDef = ClassAssetHolder.mainColor;
  final IconData editIcon = ClassAssetHolder.penIcon;
  String userImage = ClassAssetHolder.defUser;
  Color topColor = Colors.grey[400];
  PickedFile _image;

  String _uploadImageURL;

  final TextStyle subElementStyle = TextStyle(
      color: ClassAssetHolder.mainColor, fontSize: ClassScreenConf.blockV * 3);

  final EdgeInsets subElementPadding = EdgeInsets.only(
    left: ClassScreenConf.blockH * 8,
  );

  final TextStyle userDataStyle = TextStyle(
    fontFamily: ClassAssetHolder.proximaLight,
    fontWeight: FontWeight.w400,
    color: Colors.grey[800],
    fontSize: ClassScreenConf.blockV * 3,
  );

  Future<Widget> imagePicker(BuildContext context) async {
    return showDialog(
      useSafeArea: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              "Select image location",
            ),
          ),
          content: StatefulBuilder(
            builder: (context, StateSetter stateSetter) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          enableFeedback: true,
                          child: IconButton(
                            icon: Icon(
                              Icons.filter,
                            ),
                            onPressed: () async => ImagePicker()
                                .getImage(
                              source: ImageSource.gallery,
                            )
                                .then(
                              (value) {
                                _image = value;
                                stateSetter(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Gallery",
                      ),
                    ],
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          enableFeedback: true,
                          child: IconButton(
                            icon: Icon(
                              Icons.camera,
                            ),
                            onPressed: () async => ImagePicker()
                                .getImage(
                              source: ImageSource.camera,
                            )
                                .then(
                              (value) {
                                _image = value;
                                stateSetter(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                      Text(
                        "Camera",
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        );
      },
    );
  }

  Future uploadImage() async {
    _uploadImageURL = await FireStoreImageUpload().uploadImage(
      await _image.readAsBytes(),
    );
    print(_uploadImageURL);
  }

  Future<void> colorForTop(PickedFile currentImage) async {
    final ClassPrimaryColorGen primGen = ClassPrimaryColorGen();
    final Color color =
        await primGen.colorGenny(await currentImage.readAsBytes());
    topColor = color;
    await uploadImage();
  }

  Widget buildProfile(BuildContext context) {
    return Scaffold(
      body: Container(
        width: widthMax,
        height: heightMax,
        child: ChangeNotifierProvider<ValueNotifier<editState>>(
          create: (_) => ValueNotifier<editState>(editState.NONE),
          child: Builder(
            builder: (context) => profileState(
              context,
            ),
          ),
        ),
      ),
    );
  }

  Widget profileState(BuildContext context) {
    return Consumer<ValueNotifier<editState>>(
      builder: (context, value, _) {
        if (value.value == editState.NONE) {
          return defaultProfile(context);
        } else {
          return editingProfile(context);
        }
      },
    );
  }

  Stack editingProfile(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      alignment: Alignment.topLeft,
      children: <Widget>[
        topBoxBuilder(),
        GestureDetector(
          onTap: () async {
            Future.value(
              imagePicker(
                context,
              ),
            ).then(
              (_) => colorForTop(
                _image,
              ),
            );
          },
          child: profileImageBuilder(),
        ),
        Positioned(
          top: heightMin * 30,
          right: 0,
          child: Container(
            width: widthMax,
            height: heightMin * 16,
            alignment: Alignment.bottomRight,
            child: Container(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    final currentState = Provider.of<ValueNotifier<editState>>(
                        context,
                        listen: false);
                    currentState.value = editState.NONE;
                  },
                  child: Icon(
                    Icons.done,
                    size: heightMin * 4,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget topBoxBuilder() {
    return Positioned(
      top: -heightMin * 30,
      left: -widthMin * 50,
      child: Container(
        height: heightMin * 70,
        width: widthMax * 2,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: topColor,
        ),
      ),
    );
  }

  Widget profileImageBuilder() {
    return Positioned(
      top: heightMin * 30,
      child: Container(
        width: widthMax,
        height: heightMin * 18,
        child: Container(
          constraints: BoxConstraints.tight(
            Size.fromRadius(
              widthMin * 18,
            ),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            clipBehavior: Clip.antiAlias,
            child: _image == null
                ? Image.asset(
                    userImage,
                    fit: BoxFit.contain,
                  )
                : Image.asset(
                    _image.path,
                    fit: BoxFit.contain,
                    scale: widthMin * 10,
                    width: 10,
                  ),
          ),
        ),
      ),
    );
  }

  Stack defaultProfile(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      alignment: Alignment.topLeft,
      children: <Widget>[
        topBoxBuilder(),
        profileImageBuilder(),
        Positioned(
          top: heightMin * 30,
          right: 0,
          child: Container(
            width: widthMax,
            height: heightMin * 16,
            alignment: Alignment.bottomRight,
            child: Container(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    final currentState = Provider.of<ValueNotifier<editState>>(
                        context,
                        listen: false);
                    currentState.value = editState.EDITING;
                  },
                  child: Icon(
                    editIcon,
                    size: heightMin * 4,
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: heightMin * 50,
          left: 0,
          child: Container(
            width: widthMax,
            height: heightMin * 5,
            child: Center(
              child: Container(
                child: FutureBuilder(
                  future: ClassFireStoreUserinfoRetrieve().retrieveName(),
                  builder: (_, snapshot) {
                    if (snapshot.connectionState == ConnectionState.none ||
                        snapshot.connectionState == ConnectionState.waiting) {
                      return Text("");
                    } else {
                      return Text(
                        snapshot.data,
                        style: TextStyle(
                          fontFamily: fontDef,
                          fontWeight: FontWeight.w900,
                          color: colorDef,
                          fontSize: heightMin * 4.6,
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: heightMin * 60,
          child: Container(
            width: widthMax,
            height: heightMin * 18,
            child: Padding(
              padding: subElementPadding,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Address",
                      style: subElementStyle,
                    ),
                  ),
                  Positioned(
                    top: heightMin * 5,
                    child: FutureBuilder(
                      future:
                          ClassFireStoreUserinfoRetrieve().retrieveAddress(),
                      builder: (_, snapshot) {
                        if (snapshot.connectionState == ConnectionState.none ||
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return Text("");
                        } else {
                          return Text(
                            snapshot.data,
                            style: userDataStyle,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: heightMin * 77,
          child: Container(
            width: widthMax,
            height: heightMin * 12,
            child: Padding(
              padding: subElementPadding,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text("Phone", style: subElementStyle),
                  ),
                  Positioned(
                    top: heightMin * 5,
                    child: FutureBuilder(
                      future: ClassFireStoreUserinfoRetrieve().retrievePhone(),
                      builder: (_, snapshot) {
                        if (snapshot.connectionState == ConnectionState.none ||
                            snapshot.connectionState ==
                                ConnectionState.waiting) {
                          return Text("");
                        } else {
                          return Text(
                            snapshot.data,
                            style: userDataStyle,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
