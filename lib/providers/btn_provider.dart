import 'package:flutter/cupertino.dart';

class BtnProvider with ChangeNotifier {
  bool _showTextField1 = false;
  bool _showTextField2 = false;
  bool _blur = true;
  bool _success = false;
  bool _isGuest = false;

  bool get showTextField1 => _showTextField1;
  bool get showTextField2 => _showTextField2;
  bool get blur => _blur;
  bool get success => _success;
  bool get isGuest => _isGuest;

  void toggleTextField1() {
    _showTextField1 = !_showTextField1;
    notifyListeners();
  }

  void toggleTextField2() {
    _showTextField2 = !_showTextField2;
    notifyListeners();
  }

  void hideBlur() {
    _blur = false;
    notifyListeners();
  }

  set success(bool value) {
    _success = value;
    notifyListeners();
  }

  void setGuest() {
    _isGuest = true;
    notifyListeners();
  }
}