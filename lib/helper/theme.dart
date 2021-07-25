import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTheme {
  const CustomTheme();

  static Color colorAccent = Color(0xff007EF4);
  static Color textColor = Color(0xff071930);
  static const Color loginGradientStart = Colors.redAccent;
  static const Color loginGradientEnd = Color(0xff2A75BC);
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: <Color>[loginGradientStart, loginGradientEnd],
    stops: <double>[0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
