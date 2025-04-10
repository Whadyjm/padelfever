import 'package:flutter/material.dart';
import '../models/game.dart';
import '../theme/text.dart';

class ScoreDisplay extends StatelessWidget {
  final int team1Points;
  final int team2Points;
  final GameSystem gameSystem;
  final VoidCallback addPointTeam1;
  final VoidCallback addPointTeam2;
  const ScoreDisplay({
    super.key,
    required this.team1Points,
    required this.team2Points,
    required this.gameSystem,
    required this.addPointTeam1,
    required this.addPointTeam2,
  });


  String _getScore(int points, bool isTieBreak) {

    if (isTieBreak) {
      return points.toString();
    }

    switch (points) {
      case 0:
        return "0";
      case 1:
        return "15";
      case 2:
        return "30";
      case 3:
        return "40";
      default:
        return "AD";
    }
  }

  @override
  Widget build(BuildContext context) {

    final isTieBreak = gameSystem == GameSystem.tieBreak;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (isTieBreak)
            const Text(
              'TIE BREAK',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          GestureDetector(
            onTap: addPointTeam1,
            child: Text(
              _getScore(team1Points, isTieBreak),
              style: TextStyle(
                fontSize: 80,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.bold,
                fontFamily: 'sf-pro-display',
              ),
            ),
          ),
          GestureDetector(
            onTap: addPointTeam2,
            child: Text(
              _getScore(team2Points, isTieBreak),
              style: TextStyle(
                fontSize: 80,
                color: Colors.grey.shade800,
                fontWeight: FontWeight.bold,
                fontFamily: 'sf-pro-display',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
