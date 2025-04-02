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
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}
