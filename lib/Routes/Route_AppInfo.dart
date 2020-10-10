// Shows a slide of quick stuff in the app

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:snatched/Utilities/Class_AssetHolder.dart';
import 'package:snatched/Utilities/Class_ScreenConf.dart';
import 'package:snatched/Utilities/Class_PermissionManager.dart';

class RouteAppInfo extends StatelessWidget {
  final double widthMin = ClassScreenConf.blockH;
  final double widthMax = ClassScreenConf.hArea;
  final double heightMin = ClassScreenConf.blockV;
  final double heightMax = ClassScreenConf.vArea;
  final List<Image> imageList = [
    Image.asset(
      ClassAssetHolder.intro1,
    ),
    Image.asset(
      ClassAssetHolder.intro2,
    ),
    Image.asset(
      ClassAssetHolder.intro3,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ValueNotifier<int>>(
      create: (context) => ValueNotifier<int>(0),
      builder: (context, _) => widgetData(context),
    );
  }

  void changeCounter(String option, BuildContext context) {
    final counter = Provider.of<ValueNotifier<int>>(context, listen: false);
    if (option == "add") {
      counter.value += 1;
    } else {
      counter.value -= 1;
    }
  }

  Widget widgetData(BuildContext context) {
    final counter = Provider.of<ValueNotifier<int>>(context, listen: false);

    return Scaffold(
      body: Container(
        height: heightMax,
        width: widthMax,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dx < -1.5 &&
                    counter.value < imageList.length - 1) {
                  changeCounter("add", context);
                } else if (details.delta.dx > 1.5 && counter.value > 0) {
                  changeCounter("minus", context);
                }
              },
              child: Center(
                child: Consumer<ValueNotifier<int>>(
                  builder: (_, counter, __) => Container(
                      width: widthMax,
                      height: heightMax,
                      color: Colors.brown[200],
                      child: imageList[counter.value]),
                ),
              ),
            ),
            Positioned(
              bottom: widthMin * 8,
              right: widthMin * 8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(
                  color: ClassAssetHolder.mainColor,
                  child: IconButton(
                    iconSize: widthMin * 10,
                    enableFeedback: true,
                    icon: Icon(
                      ClassAssetHolder.rightIcon,
                      color: Colors.white,
                      size: widthMin * 10,
                    ),
                    onPressed: () async {
                      if (counter.value < imageList.length - 1) {
                        changeCounter("add", context);
                      } else {
                        await Future.value(
                                ClassPermissionManager().askForPerms())
                            .then(
                          (_) => Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/authSignIn',
                            (_) => false,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
            /* Positioned(
              bottom: heightMin * 6,
              child: Container(
                height: heightMin * 10,
                width: widthMin * 20,
                child: Consumer<ValueNotifier<int>>(
                  builder: (_, counter, __) {
                    return Slider(

                      max: (imageList.length - 1) * 1.0,
                      value: (counter.value) * 1.0,
                      onChanged: (_) {},
                    );
                  },
                ),
              ),
            ) */
          ],
        ),
      ),
    );
  }
}
