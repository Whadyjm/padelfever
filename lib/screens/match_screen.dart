import 'package:flutter/material.dart';
import 'package:padelpoint/models/match.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import '../models/team.dart';
import '../providers/match_provider.dart';
import '../widgets/score_display.dart';

class MatchScreen extends StatefulWidget {
  final Team team1;
  final Team team2;
  final GameSystem gameSystem;

  const MatchScreen({
    super.key,
    required this.team1,
    required this.team2,
    required this.gameSystem,
  });

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends State<MatchScreen> {
  late Match _match;

  @override
  void initState() {
    super.initState();
    _match = Match(
      id: DateTime.now().toString(),
      team1: widget.team1,
      team2: widget.team2,
      gameSystem: widget.gameSystem,
    );
  }

  void _addPoint(int team) {
    setState(() {
      _match.currentGame.addPoint(team);
      final winner = _match.currentGame.getWinner();
      if (winner != null) {
        _match.addGame(winner);
        _showGameWinnerDialog(winner);
      }
    });
  }

  void _showGameWinnerDialog(int winner) {
    final team = winner == 1 ? _match.team1 : _match.team2;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Game ganado'),
        content: Text('${team.teamName} ha ganado el game!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (_match.winner.isNotEmpty) {
                _showMatchWinnerDialog();
              }
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showMatchWinnerDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: const Text('Partido terminado'),
        content: Text('${_match.winner} ha ganado el partido!'),
        actions: [
          TextButton(
            onPressed: () {
              final provider = Provider.of<MatchProvider>(context, listen: false);
              provider.addMatch(_match);
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Marcador de Pádel'),
      ),
      body: Column(
        children: [
          // Teams info
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      _match.team1.teamName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('${_match.team1.player1.name} & ${_match.team1.player2.name}'),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      _match.team2.teamName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('${_match.team2.player1.name} & ${_match.team2.player2.name}'),
                  ],
                ),
              ],
            ),
          ),

          // Games score
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Games: ${_match.team1TotalGames}',
                  style: const TextStyle(fontSize: 18),
                ),
                Text(
                  'Games: ${_match.team2TotalGames}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),

          // Current game score
          ScoreDisplay(
            team1Points: _match.currentGame.team1Points,
            team2Points: _match.currentGame.team2Points,
            gameSystem: _match.gameSystem,
          ),

          // Add points buttons
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _addPoint(1),
                    child: Container(
                      color: Colors.blue.withOpacity(0.1),
                      child: const Center(
                        child: Text(
                          'Punto para\nEquipo 1',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => _addPoint(2),
                    child: Container(
                      color: Colors.red.withOpacity(0.1),
                      child: const Center(
                        child: Text(
                          'Punto para\nEquipo 2',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}