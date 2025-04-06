import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:padelpoint/models/match.dart';
import 'package:padelpoint/theme/colors.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import '../models/team.dart';
import '../providers/match_provider.dart';
import '../theme/text.dart';
import '../widgets/score_display.dart';
import 'history_screen.dart';

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

  void _addPoint(int team, BuildContext context) {
    setState(() {
      _match.currentGame.addPoint(team);
      final winner = _match.currentGame.getWinner();
      final confettiController = Provider.of<MatchProvider>(context, listen: false).controller;
      if (winner != null) {
        confettiController.play();
        _match.addGame(winner);
        _showGameWinnerDialog(winner);
      }
    });
  }

  void _showGameWinnerDialog(int winner) {
    final team = winner == 1 ? _match.team1 : _match.team2;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (ctx) => AlertDialog(
            backgroundColor: Colors.white,
            title: Center(
              child: Text(
                'Juego ganado',
                style: AppText.titleStyle(Colors.grey.shade800),
              ),
            ),
            content: Text(
              '¡${team.teamName} ha ganado el juego!',
              style: AppText.subtitleStyle(Colors.grey.shade700),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  if (_match.winner.isNotEmpty) {
                    _showMatchWinnerDialog();
                  }
                  final confettiController = Provider.of<MatchProvider>(context, listen: false).controller;
                  confettiController.stop();
                },
                child: Center(
                  child: Text(
                    'Seguir',
                    style: AppText.subtitleStyle(Colors.blue),
                  ),
                ),
              ),
            ],
          ),
    );
  }

  void _showMatchWinnerDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (ctx) => AlertDialog(

            backgroundColor: Colors.white,
            title: Center(
              child: Text(
                'Partido terminado',
                style: AppText.titleStyle(Colors.grey.shade800),
              ),
            ),
            content: Text(
              '¡${_match.winner} ha ganado el partido!',
              style: AppText.subtitleStyle(Colors.grey.shade700),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  final provider = Provider.of<MatchProvider>(
                    context,
                    listen: false,
                  );
                  provider.addMatch(_match);
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pop();
                },
                child: Center(
                  child: Text(
                    'Salir',
                    style: AppText.subtitleStyle(Colors.blue),
                  ),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final matchProvider = Provider.of<MatchProvider>(context);
    final Color greyColor = Colors.grey.shade700;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColorLight,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        ),
        title: Text('Marcador', style: AppText.titleStyle(Colors.white)),
        actions: [
          IconButton(
            onPressed:
                () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HistoryScreen()),
                ),
            icon: Icon(Icons.history, color: Colors.white, size: 30),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.primaryColorLight,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Juegos: ${_match.team1TotalGames}',
                                  style: AppText.smallTextStyle(Colors.white),
                                ),
                                Text(
                                  _match.team1.teamName,
                                  style: AppText.smallTextStyle(Colors.white),
                                ),
                                Text(
                                  '${_match.team1.player1.name} - ${_match.team1.player2.name}',
                                  style: AppText.verySmallTextStyle(Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColorLight,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Juegos: ${_match.team2TotalGames}',
                                  style: AppText.smallTextStyle(Colors.white),
                                ),
                                Text(
                                  _match.team2.teamName,
                                  style: AppText.smallTextStyle(Colors.white),
                                ),
                                Text(
                                  '${_match.team2.player1.name} - ${_match.team2.player2.name}',
                                  style: AppText.verySmallTextStyle(Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => _addPoint(1, context),
                            child: Container(
                              height: 200,
                              width: 200,
                              color: Colors.blue.shade300,
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => _addPoint(2, context),
                            child: Container(
                              height: 200,
                              width: 200,
                              color: Colors.green.shade300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ScoreDisplay(
                      team1Points: _match.currentGame.team1Points,
                      team2Points: _match.currentGame.team2Points,
                      gameSystem: _match.gameSystem,
                      addPointTeam1: () => _addPoint(1, context),
                      addPointTeam2: () => _addPoint(2, context),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ConfettiWidget(
            numberOfParticles: 5,
            emissionFrequency: 0.25,
            confettiController: matchProvider.controller,
            shouldLoop: true,
            blastDirectionality: BlastDirectionality.explosive,),
        ]
      ),
    );
  }
}
