import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snatched/Utilities/Class_FireStoreUserinfoRetrieve.dart';

import 'package:provider/provider.dart';

import 'package:snatched/Utilities/Class_ScreenConf.dart';
import 'package:snatched/Utilities/Class_AssetHolder.dart';
import 'package:snatched/Utilities/Raw_ColorForTop.dart';
import 'package:snatched/Utilities/Class_FireStoreImageUpload.dart';
import 'package:snatched/Utilities/Class_FireStoreImageRetrieve.dart';
import 'package:snatched/Utilities/Class_LocalProfileImageStorage.dart';

enum editState {
  NONE,
  EDITING,
}

enum profileImageState {
  DEFAULT,
  EDITED,
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
  Color topColor;
  final double imageRadius = ClassScreenConf.blockH * 18;
  PickedFile _image;

  RouteProfile(String imagePath, this.topColor)
      : _image = PickedFile(imagePath);

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

  Future<Widget> imagePicker(BuildContext ogcontext) async {
    return showDialog(
      useSafeArea: true,
      context: ogcontext,
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
                                    imageQuality: 90,
                                    maxHeight: imageRadius,
                                    maxWidth: imageRadius)
                                .then(
                              (value) {
                                final path = Provider.of<ValueNotifier<String>>(
                                    ogcontext,
                                    listen: false);
                                path.value = value.path;
                                _image = value;
                                print("Profile Image set");

                                stateSetter(() {});

                                Navigator.of(context).pop();
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
                              preferredCameraDevice: CameraDevice.front,
                              maxWidth: imageRadius,
                              maxHeight: imageRadius,
                              imageQuality: 90,
                            )
                                .then(
                              (value) {
                                final path = Provider.of<ValueNotifier<String>>(
                                    ogcontext,
                                    listen: false);
                                path.value = value.path;
                                _image = value;
                                print("Profile Image set");
                                stateSetter(() {});

                                Navigator.of(context).pop();
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

  Future storeImage() async {
    await ClassLocalProfileImageStorage()
        .storeImage(await _image.readAsBytes());
  }

  Future uploadImage() async {
    _uploadImageURL = await FireStoreImageUpload().uploadImage(
      await _image.readAsBytes(),
    );
    print(_uploadImageURL);
  }

  Widget buildProfile(BuildContext context) {
    return Scaffold(
      body: Container(
        width: widthMax,
        height: heightMax,
        child: MultiProvider(
          providers: [
            ChangeNotifierProvider<ValueNotifier<editState>>(
              create: (_) => ValueNotifier<editState>(editState.NONE),
            ),
            ChangeNotifierProvider<ValueNotifier<String>>(
              create: (_) => ValueNotifier<String>(_image.path),
            ),
          ],
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
        Positioned(
          top: heightMin * 30,
          child: GestureDetector(
            onTap: () async {
              await Future.value(
                imagePicker(
                  context,
                ),
              ).then((_) async {
                topColor = await colorForTop(
                  _image.path,
                );
              }).then((_) async {
                await uploadImage();
                await storeImage();
              });
            },
            child: profileImageBuilder(context),
          ),
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

  Widget profileImageBuilder(BuildContext context) {
    return Container(
      width: widthMax,
      height: heightMin * 18,
      child: Container(
        constraints: BoxConstraints.tight(
          Size.fromRadius(
            imageRadius,
          ),
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
        ),
        child: Consumer<ValueNotifier<String>>(
          builder: (context, value, _) {
            return ClipOval(
              clipBehavior: Clip.antiAlias,
              child: Image.asset(
                value.value,
                errorBuilder: (context, _, __) {
                  return imageError(context);
                },
                fit: BoxFit.contain,
                scale: widthMin * 10,
                width: 10,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget imageError(BuildContext ogcontext) {
    print("Image Loading Error !");
    return FutureBuilder(
      future: ClassFireStoreImageRetrieve().imageStatus(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data) {
            return FutureBuilder(
              future: ClassFireStoreImageRetrieve().getImage(),
              builder: (_, snapshot2) {
                if (snapshot2.connectionState == ConnectionState.done) {
                  _image = PickedFile(snapshot2.data);
                  final imageState = Provider.of<ValueNotifier<String>>(
                      ogcontext,
                      listen: false);
                  Future.value(storeImage())
                      .then(
                        (_) => Future.value(
                          ClassLocalProfileImageStorage().localFile,
                        ),
                      )
                      .then((value) => imageState.value = value.path);

                  return Image.asset(
                    imageState.value,
                    fit: BoxFit.contain,
                    scale: widthMin * 10,
                    width: 10,
                  );
                } else {
                  return Container();
                }
              },
            );
          } else {
            final imageState =
                Provider.of<ValueNotifier<String>>(ogcontext, listen: false);
            imageState.value = userImage;
            return Image.asset(
              imageState.value,
              fit: BoxFit.contain,
              scale: widthMin * 10,
              width: 10,
            );
          }
        } else {
          return Container();
        }
      },
    );
  }

  Stack defaultProfile(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      overflow: Overflow.visible,
      alignment: Alignment.topLeft,
      children: <Widget>[
        topBoxBuilder(),
        Positioned(
          top: heightMin * 30,
          child: profileImageBuilder(context),
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
