import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:provider/provider.dart';

import 'package:snatched/Utilities/Class_ScreenConf.dart';
import 'package:snatched/Utilities/Class_AssetHolder.dart';
import 'package:snatched/Utilities/Raw_ColorForTop.dart';
import 'package:snatched/Utilities/Class_FireStoreImageUpload.dart';
import 'package:snatched/Utilities/Class_FireStoreImageRetrieve.dart';
import 'package:snatched/Utilities/Class_LocalProfileImageStorage.dart';

import 'package:snatched/Utilities/Class_FireStoreUserinfoStorage.dart';
import 'package:snatched/Utilities/Class_FireStoreUserinfoRetrieve.dart';

enum editState {
  NONE,
  EDITING,
}

enum profileImageState {
  DEFAULT,
  EDITED,
}

enum profileNameState {
  DEFAULT,
  EDITING,
}

enum profileAddressState {
  DEFAULT,
  EDITING,
}
enum profilePhoneState {
  DEFAULT,
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
  final String defaultImage = ClassAssetHolder.defUser;
  Color topColor;
  final double imageRadius = ClassScreenConf.blockH * 18;
  PickedFile _image;
  TextEditingController nameEditor = TextEditingController();
  TextEditingController phoneEditor = TextEditingController();
  TextEditingController address1Editor = TextEditingController();
  TextEditingController address2Editor = TextEditingController();
  TextEditingController address3Editor = TextEditingController();
  TextStyle nameStyle = TextStyle(
    fontFamily: ClassAssetHolder.proximaLight,
    fontWeight: FontWeight.w900,
    color: ClassAssetHolder.mainColor,
    fontSize: ClassScreenConf.blockV * 4.6,
  );
  String name;
  String phone;
  String address1;
  String address2;
  String address3;

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

  Future imageErrorResult(PickedFile imageData, BuildContext context) async {
    _image = imageData;
    await storeImage();
    File imageFile = await ClassLocalProfileImageStorage().localFile;
    final imageState =
        Provider.of<ValueNotifier<String>>(context, listen: false);
    imageState.value = imageFile.path;
    print("New Image Set !");
    
    return imageState;
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
            ChangeNotifierProvider<ValueNotifier<profileNameState>>(
              create: (_) =>
                  ValueNotifier<profileNameState>(profileNameState.DEFAULT),
            ),
            ChangeNotifierProvider<ValueNotifier<profileAddressState>>(
              create: (_) => ValueNotifier<profileAddressState>(
                  profileAddressState.DEFAULT),
            ),
            ChangeNotifierProvider<ValueNotifier<profilePhoneState>>(
              create: (_) =>
                  ValueNotifier<profilePhoneState>(profilePhoneState.DEFAULT),
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
                  onTap: () async {
                    final currentState = Provider.of<ValueNotifier<editState>>(
                        context,
                        listen: false);
                    if (nameEditor.text != name) {
                      await ClassFireStoreUserInfoStorage.storeName(
                          nameEditor.text);
                    }
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
        Positioned(
          top: heightMin * 50,
          left: 0,
          child: GestureDetector(
            child: Consumer<ValueNotifier<profileNameState>>(
                builder: (__, value, _) {
              if (value.value == profileNameState.DEFAULT) {
                return nameBuilder();
              } else {
                return nameEditorBuilder();
              }
            }),
            onTap: () {
              final provider = Provider.of<ValueNotifier<profileNameState>>(
                  context,
                  listen: false);
              provider.value = profileNameState.EDITING;
            },
          ),
        ),
        Positioned(
          top: heightMin * 60,
          child: GestureDetector(
            child: Consumer<ValueNotifier<profileAddressState>>(
                builder: (__, value, _) {
              if (value.value == profileAddressState.DEFAULT) {
                return addressBuilder();
              } else {
                return addressBuilder();
              }
            }),
            onTap: () {
              final provider = Provider.of<ValueNotifier<profileAddressState>>(
                  context,
                  listen: false);
              provider.value = profileAddressState.EDITING;
            },
          ),
        ),
        Positioned(
          top: heightMin * 77,
          child: GestureDetector(
            child: Consumer<ValueNotifier<profilePhoneState>>(
                builder: (__, value, _) {
              if (value.value == profilePhoneState.DEFAULT) {
                return phoneBuilder();
              } else {
                return phoneBuilder();
              }
            }),
            onTap: () {
              final provider = Provider.of<ValueNotifier<profilePhoneState>>(
                  context,
                  listen: false);
              provider.value = profilePhoneState.EDITING;
            },
          ),
        ),
      ],
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
          child: nameBuilder(),
        ),
        Positioned(
          top: heightMin * 60,
          child: addressBuilder(),
        ),
        Positioned(
          top: heightMin * 77,
          child: phoneBuilder(),
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
      child: Center(
        child: Container(
          width: imageRadius,
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
              return Container(
                child: imageBuilderResult(value, context),
              );
            },
          ),
        ),
      ),
    );
  }

  Container imageBuilderResult(
      ValueNotifier<String> value, BuildContext context) {
    try {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            onError: (
              __,
              _,
            ) {
              return imageError(context);
            },
            image: AssetImage(
              value.value,
            ),
          ),
        ),
      );
    } on Exception {
      return Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(
              defaultImage,
            ),
          ),
        ),
      );
    }
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
                  return FutureBuilder(
                    future:
                        imageErrorResult(PickedFile(snapshot2.data), ogcontext),
                    builder: (_, snapshot3) {
                      if (snapshot3.connectionState == ConnectionState.done) {
                        print("Image error complete");
                        return Container(
                          child: imageBuilderResult(snapshot3.data, ogcontext),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                } else {
                  return Container();
                }
              },
            );
          } else {
            final imageState =
                Provider.of<ValueNotifier<String>>(ogcontext, listen: false);
            imageState.value = defaultImage;
            return Container(
              child: imageBuilderResult(imageState, ogcontext),
            );
          }
        } else {
          return Container();
        }
      },
    );
  }

  Widget nameBuilder() {
    return Container(
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
                Map<int, String> map = snapshot.data;
                nameEditor.text = "${map[1]} ${map[2]}";
                name = "${map[1]} ${map[2]}";
                return Text(
                  name,
                  style: nameStyle,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget nameEditorBuilder() {
    double width = widthCalculator(nameEditor.text);
    return Container(
      width: widthMax,
      height: heightMin * 5,
      child: Center(
        child: Container(
          child: StatefulBuilder(builder: (context, StateSetter statesetter) {
            return AnimatedContainer(
              duration: Duration(milliseconds: 10),
              width: width,
              child: TextField(
                controller: nameEditor,
                onChanged: (string) {
                  width = widthCalculator(string);
                  statesetter(() {});
                },
                style: nameStyle,
                maxLines: 1,
              ),
            );
          }),
        ),
      ),
    );
  }

  double widthCalculator(String string) {
    if (string.length > 5) {
      double width;
      TextSpan textSpan = TextSpan(text: nameEditor.text, style: nameStyle);
      TextPainter textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.center);
      textPainter.layout(maxWidth: widthMax);
      width = textPainter.width * 1.05;
      return width;
    } else {
      return widthMin * 20;
    }
  }

  Container phoneBuilder() {
    return Container(
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
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Text("");
                  } else {
                    phoneEditor.text = snapshot.data;
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
    );
  }

  Container addressBuilder() {
    return Container(
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
                future: ClassFireStoreUserinfoRetrieve().retrieveAddress(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.none ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return Text("");
                  } else {
                    Map<int, String> map = snapshot.data;
                    address1Editor.text = map[1];
                    address2Editor.text = map[2];
                    address3Editor.text = map[3];
                    return Text(
                      "${map[1]}\n${map[2]}\n${map[3]}\n",
                      style: userDataStyle,
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
