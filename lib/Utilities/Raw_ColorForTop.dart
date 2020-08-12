import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snatched/Utilities/Class_primaryColorGen.dart';

Future<Color> colorForTop(String imageData) async {
  final PickedFile currentImage=PickedFile(imageData);
    final ClassPrimaryColorGen primGen = ClassPrimaryColorGen();
    final Color color =
        await primGen.colorGenny(await currentImage.readAsBytes());
    return color;
  }