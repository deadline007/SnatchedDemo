import 'dart:typed_data';

import 'package:palette_generator/palette_generator.dart';
import 'package:flutter/material.dart';

class ClassPrimaryColorGen {
  Future<Color> colorGenny(Uint8List imageData) async {
    final ImageProvider image = Image.memory(imageData).image;
    final PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(image);
    return paletteGenerator.dominantColor.color;
  }
}
