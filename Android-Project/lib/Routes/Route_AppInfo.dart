// Shows a slide of quick stuff in the app

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:snatched/Utilities/Class_AssetHolder.dart';
import 'package:snatched/Utilities/Class_ScreenConf.dart';

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

  Widget widgetData(BuildContext context) {
    final counter = Provider.of<ValueNotifier<int>>(context, listen: false);
    return Scaffold(
      body: Container(
        height: heightMax,
        width: widthMax,
        child: Stack(
          children: <Widget>[
            Center(
              child: Consumer<ValueNotifier<int>>(
                builder: (_, counter, __) => imageList[counter.value],
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
                    onPressed: () {
                      if (counter.value < 3) {
                        counter.value += 1;
                      } else {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/authRoute',
                          (_) => false,
                        );
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
