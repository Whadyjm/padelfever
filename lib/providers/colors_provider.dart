import 'dart:ui';

import 'package:flutter/material.dart';

class ColorsProvider with ChangeNotifier{
  Color _team1Color = Colors.blue;
  Color _team2Color = Colors.green;

  Color get team1Color => _team1Color;
  Color get team2Color => _team2Color;

  set team1Color(Color color) {
    _team1Color = color;
    notifyListeners();
  }

  set team2Color(Color color) {
    _team2Color = color;
    notifyListeners();
  }
}