import 'package:flutter/cupertino.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? weight;
  final Color? color;
  final String? fontFamily;
  const CustomText({super.key, required this.text, this.fontSize, this.weight, this.color, this.fontFamily});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: weight,
        color: color,
        fontFamily: fontFamily,
      ),
    );
  }
}
