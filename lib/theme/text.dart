import 'dart:ui';

import 'package:flutter/material.dart';

class AppText {

  static TextStyle titleStyle(Color textColor) => TextStyle(
    fontFamily: 'sf-pro-display',
    color: textColor,
    fontSize: 25,
    fontWeight: FontWeight.w800,
  );

  static TextStyle subtitleStyle(Color textColor) => TextStyle(
    fontFamily: 'sf-pro-display',
    color: textColor,
    fontSize: 20,
    fontWeight: FontWeight.w700,
  );

  static TextStyle smallTextStyle(Color textColor) => TextStyle(
    fontFamily: 'sf-pro-display',
    color: textColor,
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  static TextStyle verySmallTextStyle(Color textColor) => TextStyle(
    fontFamily: 'sf-pro-display',
    color: textColor,
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );
}
