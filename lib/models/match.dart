import 'package:padelpoint/models/game.dart';
import 'package:padelpoint/models/team.dart';

class Match {
  final String id;
  final DateTime date;
  final Team team1;
  final Team team2;
  final GameSystem gameSystem;
  List<int> team1Games = [];
  List<int> team2Games = [];
  Game currentGame;

  Match({
    required this.id,
    required this.team1,
    required this.team2,
    required this.gameSystem,
  })  : date = DateTime.now(),
        currentGame = Game(system: gameSystem);

  void addGame(int winner) {
    if (winner == 1) {
      team1Games.add(1);
    } else {
      team2Games.add(1);
    }

    // Check if we need to play tie-break
    if (team1Games.length == 6 && team2Games.length == 6) {
      currentGame = Game(system: GameSystem.tieBreak);
    } else {
      currentGame = Game(system: gameSystem);
    }
  }

  int get team1TotalGames => team1Games.length;
  int get team2TotalGames => team2Games.length;

  String get winner {
    // Check for normal win (6 games with 2 games difference)
    if (team1TotalGames >= 6 && team1TotalGames >= team2TotalGames + 2) {
      return team1.teamName;
    }
    if (team2TotalGames >= 6 && team2TotalGames >= team1TotalGames + 2) {
      return team2.teamName;
    }

    // Check for tie-break win (7-6)
    if (team1TotalGames == 7 && team2TotalGames == 6) {
      return team1.teamName;
    }
    if (team2TotalGames == 7 && team1TotalGames == 6) {
      return team2.teamName;
    }

    return '';
  }
}