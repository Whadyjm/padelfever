import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import '../models/match.dart';
import '../models/player.dart';
import '../models/team.dart';
import '../models/game.dart';

class MatchProvider with ChangeNotifier {
  List<Match> _matches = [];
  List<Player> _players = [];
  ConfettiController _controller = ConfettiController();

  ConfettiController get controller => _controller;
  List<Match> get matches => [..._matches];
  List<Player> get players => [..._players];

  void addMatch(Match match) {
    _matches.add(match);
    notifyListeners();
  }

  void addPlayer(Player player) {
    _players.add(player);
    notifyListeners();
  }

  void clearPlayers() {
    _players.clear();
    notifyListeners();
  }

  void clearMatches() {
    _matches.clear();
    notifyListeners();
  }

  void startConfetti() {
    _controller.play();
  }

  void stopConfetti() {
    _controller.stop();
  }

  List<Team> createRandomTeams() {
    if (_players.length < 4) {
      throw Exception('Se necesitan al menos 4 jugadores');
    }

    _players.shuffle();
    return [
      Team(
        id: DateTime.now().toString(),
        name: '',
        player1: _players[0],
        player2: _players[1],
        color: Colors.blue,
      ),
      Team(
        id: DateTime.now().toString() + '2',
        name: '',
        player1: _players[2],
        player2: _players[3],
        color: Colors.green,
      ),
    ];
  }
}
