enum GameSystem { advantage, goldenPoint }

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
    if (system == GameSystem.advantage) {
      if (team1Points >= 4 && team1Points >= team2Points + 2) {
        return 1;
      }
      if (team2Points >= 4 && team2Points >= team1Points + 2) {
        return 2;
      }
    } else { // goldenPoint
      if (team1Points >= 4) return 1;
      if (team2Points >= 4) return 2;
    }
    return null;
  }

  String getScore(int points) {
    switch (points) {
      case 0: return "0";
      case 1: return "15";
      case 2: return "30";
      case 3: return "40";
      default: return "AD";
    }
  }
}