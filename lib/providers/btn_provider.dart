import 'package:flutter/cupertino.dart';

class BtnProvider with ChangeNotifier {

  bool _showTextField1 = false;
  bool _showTextField2 = false;

  bool get showTextField1 => _showTextField1;
  bool get showTextField2 => _showTextField2;

  void toggleTextField1() {
    _showTextField1 = !_showTextField1;
    notifyListeners();
  }

  void toggleTextField2() {
    _showTextField2 = !_showTextField2;
    notifyListeners();
  }
}