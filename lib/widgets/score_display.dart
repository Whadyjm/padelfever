import 'package:flutter/material.dart';
import '../models/game.dart';

class ScoreDisplay extends StatelessWidget {
  final int team1Points;
  final int team2Points;
  final GameSystem gameSystem;

  const ScoreDisplay({
    super.key,
    required this.team1Points,
    required this.team2Points,
    required this.gameSystem,
  });

  String _getScore(int points) {
    switch (points) {
      case 0: return "0";
      case 1: return "15";
      case 2: return "30";
      case 3: return "40";
      default: return "AD";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            _getScore(team1Points),
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          Text(
            'VS',
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey[600],
            ),
          ),
          Text(
            _getScore(team2Points),
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}