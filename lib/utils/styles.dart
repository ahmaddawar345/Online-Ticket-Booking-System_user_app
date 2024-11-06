import 'package:flutter/material.dart';

class AppColors {
  static Color primaryColor = greenLight;
  static Color secondaryColor = yellow;

  ///
  static Color greenLight = const Color(0XFF0CF14C);
  static Color greenDark = const Color(0XFF265533);
  static Color blackDark = const Color(0xff2D3142);
  static Color appBarBG = const Color(0XFF30D15D);
  static Color yellow = Colors.yellow;
}

final gradientGreen = LinearGradient(
  colors: [
    AppColors.greenLight,
    AppColors.greenDark,
  ],
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
);

class TextStyles {
  static const normalW500 = TextStyle(fontSize: 14, color: Colors.black54, fontWeight: FontWeight.w500);
  static const bold16 = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  static const bold18 = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
}
