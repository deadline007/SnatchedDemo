import 'package:flutter/material.dart';

class ClassSignUpSliderTheme extends SliderComponentShape {
  final double thumbRadius;
  final int min;
  final int max;

  const ClassSignUpSliderTheme(
      {@required this.thumbRadius, this.max, this.min});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {Animation<double> activationAnimation,
      Animation<double> enableAnimation,
      bool isDiscrete,
      TextPainter labelPainter,
      RenderBox parentBox,
      SliderThemeData sliderTheme,
      TextDirection textDirection,
      Size sizeWithOverflow,
      double textScaleFactor,
      double value}) {
    assert(context != null);
    assert(center != null);
    assert(enableAnimation != null);
    assert(sliderTheme != null);
    assert(sliderTheme.disabledThumbColor != null);
    assert(sliderTheme.thumbColor != null);

    // This is the difference here:
    // assert(!sizeWithOverflow.isEmpty);

    sizeWithOverflow = parentBox.size;
    final Canvas canvas = context.canvas;
    final Paint paint = Paint()
      ..color = Color(0xFFFE0265)
      ..style = PaintingStyle.fill;

    TextSpan span = TextSpan(
      text: "${getValue(value)}",
      style: TextStyle(
        fontSize: thumbRadius * 0.8,
        fontWeight: FontWeight.w700,
        color: Colors.orange[400],
      ),
    );

    TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();

    Offset textCenter =
        Offset(center.dx - (tp.width / 2), center.dy - (tp.height / 2));

    canvas.drawCircle(center, thumbRadius * 0.9, paint);
    tp.paint(canvas, textCenter);
  }

  String getValue(double value) {
    return ((max * value).round()).toString();
  }
}
