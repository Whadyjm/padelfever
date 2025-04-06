enum GameSystem { advantage, goldenPoint, tieBreak }

class Game {
  int team1Points = 0;
  int team2Points = 0;
  final GameSystem system;

  Game({required this.system});

  void addPoint(int team) {
    if (team == 1) {
      team1Points++;
    } else {
      team2Points++;
    }
  }

  void reset() {
    team1Points = 0;
    team2Points = 0;
  }

  int? getWinner() {
    switch (system) {
      case GameSystem.advantage:
        if (team1Points >= 4 && team1Points >= team2Points + 2) {
          return 1;
        }
        if (team2Points >= 4 && team2Points >= team1Points + 2) {
          return 2;
        }
        break;
      case GameSystem.goldenPoint:
        if (team1Points >= 4) return 1;
        if (team2Points >= 4) return 2;
        break;
      case GameSystem.tieBreak:
        if (team1Points >= 7 && team1Points >= team2Points + 2) {
          return 1;
        }
        if (team2Points >= 7 && team2Points >= team1Points + 2) {
          return 2;
        }
        break;
    }
    return null;
  }

  String getScore(int points) {
    if (system == GameSystem.tieBreak) {
      return points.toString();
    }

    switch (points) {
      case 0: return "0";
      case 1: return "15";
      case 2: return "30";
      case 3: return "40";
      default: return "AD";
    }
  }
}