import 'package:confetti/confetti.dart'; // Para efectos de confeti
import 'package:flutter/material.dart';
import 'package:padelpoint/models/match.dart';
import 'package:padelpoint/providers/colors_provider.dart';
import 'package:padelpoint/theme/colors.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import '../models/team.dart';
import '../providers/match_provider.dart';
import '../theme/text.dart';
import '../widgets/score_display.dart';
import 'history_screen.dart';

/// Pantalla principal del partido de pádel
/// Muestra el marcador en tiempo real y permite registrar puntos
class MatchScreen extends StatefulWidget {
  final Team team1; // Primer equipo
  final Team team2; // Segundo equipo
  final GameSystem gameSystem; // Sistema de juego seleccionado

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
  late Match _match; // Instancia del partido actual

  @override
  void initState() {
    super.initState();
    // Inicializa un nuevo partido con los equipos y sistema de juego
    _match = Match(
      id: DateTime.now().toString(),
      team1: widget.team1,
      team2: widget.team2,
      gameSystem: widget.gameSystem,
    );
  }

  /// Añade un punto al equipo especificado
  void _addPoint(int team, BuildContext context) {
    setState(() {
      _match.currentGame.addPoint(team); // Añade el punto al juego actual
      final winner = _match.currentGame.getWinner(); // Verifica si hay ganador
      final confettiController =
          Provider.of<MatchProvider>(context, listen: false).controller;

      if (winner != null) {
        confettiController.play(); // Dispara confeti
        _match.addGame(winner); // Añade el juego ganado al marcador
        _showGameWinnerDialog(winner); // Muestra diálogo de juego ganado
      }
    });
  }

  /// Muestra diálogo cuando un equipo gana un juego
  void _showGameWinnerDialog(int winner) {
    final team = winner == 1 ? _match.team1 : _match.team2;
    showDialog(
      context: context,
      barrierDismissible: false, // Obliga al usuario a interactuar
      builder: (ctx) => AlertDialog(
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
                _showMatchWinnerDialog(); // Si hay ganador del partido
              }
              // Detiene el efecto de confeti
              final confettiController =
                  Provider.of<MatchProvider>(context, listen: false).controller;
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

  /// Muestra diálogo cuando un equipo gana el partido
  void _showMatchWinnerDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
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
              // Guarda el partido en el historial
              final provider = Provider.of<MatchProvider>(
                context,
                listen: false,
              );
              provider.addMatch(_match);
              Navigator.of(ctx).pop();
              Navigator.of(context).pop(); // Regresa a la pantalla anterior
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
    // Obtiene referencias a los datos y providers necesarios
    Game currentGame = _match.currentGame;
    List team1Games = _match.team1Games;
    List team2Games = _match.team2Games;
    final matchProvider = Provider.of<MatchProvider>(context);
    final colorProvider = Provider.of<ColorsProvider>(context);

    // Verifica si estamos en un tie-break
    final bool isTieBreak =
        _match.team1TotalGames == 6 && _match.team2TotalGames == 6;

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
          // Botón para resetear el marcador
          TextButton(
            onPressed: () {
              setState(() {
                team1Games.clear();
                team2Games.clear();
                currentGame.reset();
              });
            },
            child: Text('Reset', style: AppText.smallTextStyle(Colors.white)),
          ),
          // Botón para ver el historial
          IconButton(
            onPressed: () => Navigator.push(
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
                // Sección superior con información de los equipos
                Row(
                  children: [
                    // Equipo 1
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: colorProvider.team1Color,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 80,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.white38,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
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
                                    style: AppText.verySmallTextStyle(
                                      Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Equipo 2
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          color: colorProvider.team2Color,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              height: 80,
                              width: 180,
                              decoration: BoxDecoration(
                                color: Colors.white38,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
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
                                    style: AppText.verySmallTextStyle(
                                      Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Área principal para marcar puntos
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Fondos táctiles para añadir puntos
                    Row(
                      children: [
                        // Área del equipo 1
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              _addPoint(1, context);
                            },
                            child: Container(
                              height: 200,
                              width: 200,
                              color: colorProvider.team1Color.withAlpha(80),
                            ),
                          ),
                        ),
                        // Área del equipo 2
                        Expanded(
                          child: InkWell(
                            onTap: () => _addPoint(2, context),
                            child: Container(
                              height: 200,
                              width: 200,
                              color: colorProvider.team2Color.withAlpha(80),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Widget que muestra el marcador actual
                    ScoreDisplay(
                      team1Points: _match.currentGame.team1Points,
                      team2Points: _match.currentGame.team2Points,
                      gameSystem: _match.gameSystem,
                      addPointTeam1: () => _addPoint(1, context),
                      addPointTeam2: () => _addPoint(2, context),
                    ),
                  ],
                ),
                // Indicador de tie-break (si aplica)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isTieBreak
                          ? Text(
                        'Tie Break',
                        style: AppText.titleStyle(Colors.redAccent),
                      )
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Efecto de confeti (oculto hasta que se gana un juego)
          ConfettiWidget(
            numberOfParticles: 5,
            emissionFrequency: 0.25,
            confettiController: matchProvider.controller,
            shouldLoop: true,
            blastDirectionality: BlastDirectionality.explosive,
          ),
        ],
      ),
    );
  }
}