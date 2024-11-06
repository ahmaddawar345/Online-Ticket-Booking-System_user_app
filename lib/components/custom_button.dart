import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double elevation;
  final Color fillColor;
  final Color splashColor;
  final Color highlightColor;
  final EdgeInsets padding;
  final ShapeBorder shape;
  final Widget child;

  const CustomButton({
    Key? key,
    required this.onPressed,
    this.elevation = 10.0,
    this.fillColor = Colors.white,
    this.splashColor = Colors.red,
    this.highlightColor = Colors.yellow,
    this.padding = const EdgeInsets.all(10.0),
    this.shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(25)),
    ),
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: elevation,
      fillColor: fillColor,
      splashColor: splashColor,
      highlightColor: highlightColor,
      padding: padding,
      shape: shape,
      child: child,
    );
  }
}
