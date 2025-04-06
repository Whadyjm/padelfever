import 'package:flutter/material.dart';

class PlayersProvider with ChangeNotifier {
  String _team1Player1 = '';
  String _team1Player2 = '';
  String _team2Player1 = '';
  String _team2Player2 = '';
  String _team1 = 'Team A';
  String _team2 = 'Team B';

  String get team1Player1 => _team1Player1;
  String get team1Player2 => _team1Player2;
  String get team2Player1 => _team2Player1;
  String get team2Player2 => _team2Player2;
  String get team1 => _team1;
  String get team2 => _team2;

  void setTeam1(String name) {
    _team1 = name;
    notifyListeners();
  }

  void setTeam2(String name) {
    _team2 = name;
    notifyListeners();
  }

  void setTeam1Player1(String name) {
    _team1Player1 = name;
    notifyListeners();
  }

  void setTeam1Player2(String name) {
    _team1Player2 = name;
    notifyListeners();
  }

  void setTeam2Player1(String name) {
    _team2Player1 = name;
    notifyListeners();
  }

  void setTeam2Player2(String name) {
    _team2Player2 = name;
    notifyListeners();
  }
}