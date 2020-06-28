import 'package:flutter/material.dart';

class ClassScreenConf {
  static double vArea;
  static double hArea;
  static double blockV;
  static double blockH;

  void init(BuildContext context) {
    final _mediaQ = MediaQuery.of(context);
    vArea = _mediaQ.size.height;
    hArea = _mediaQ.size.width;
    blockV = (_mediaQ.size.height) / 100;
    blockH = (_mediaQ.size.width) / 100;
  }
}
