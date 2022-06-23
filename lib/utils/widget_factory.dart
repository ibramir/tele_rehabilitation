import 'package:flutter/material.dart';

class WidgetFactory {
  static Card card(
      {Color? color,
        Color? shadowColor,
        double? elevation,
        ShapeBorder? shape,
        bool borderOnForeground = true,
        EdgeInsetsGeometry? margin,
        Clip? clipBehavior,
        Widget? child,
        bool semanticContainer = true}) {
    return Card(
        color: color,
        shadowColor: shadowColor,
        elevation: elevation ?? 2,
        shape: shape ??
            const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16))),
        borderOnForeground: borderOnForeground,
        margin: margin,
        clipBehavior: clipBehavior,
        child: child,
        semanticContainer: semanticContainer);
  }
}
