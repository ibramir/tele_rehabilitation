import 'dart:math';

import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  ProgressBar(
      {Key? key,
      required this.value,
      this.height = 4.0,
      this.width = double.infinity,
      Color? color,
      this.backgroundColor = const Color.fromARGB(255, 226, 226, 226),
      this.margin = const EdgeInsets.only(bottom: 8.0),
      this.radius = const Radius.circular(3.0)})
      : super(key: key) {
    if (color != null) {
      this.color = color;
    } else {
      num valueSquared = pow(value, 2);
      this.color = HSVColor.fromAHSV(1.0, 7 + (valueSquared * 130),
              0.79 - valueSquared * 0.28, 0.68 + valueSquared * 0.03)
          .toColor();
    }
  }

  final double height;
  final double width;
  final EdgeInsets margin;
  final Color backgroundColor;
  late final Color color;
  final Radius radius;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(radius),
      ),
      clipBehavior: Clip.antiAlias,
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: value,
        heightFactor: 1.0,
        child: Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(radius),
            ),
            clipBehavior: Clip.antiAlias),
      ),
    );
  }
}
