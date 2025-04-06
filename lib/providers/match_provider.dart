import 'package:confetti/confetti.dart'; // Para efectos de confeti
import 'package:flutter/material.dart'; // Para Material Design y Colors
import '../models/match.dart'; // Modelo de partido
import '../models/player.dart'; // Modelo de jugador
import '../models/team.dart'; // Modelo de equipo
import '../models/game.dart'; // Modelo de juego

/// Provider principal para la gestión de partidos de pádel.
///
/// Este provider centraliza:
/// - Listado de partidos históricos
/// - Jugadores disponibles
/// - Creación de equipos aleatorios
/// - Efectos visuales (confeti)
class MatchProvider with ChangeNotifier {
  // Listado privado de partidos registrados
  List<Match> _matches = [];

  // Listado privado de jugadores disponibles
  List<Player> _players = [];

  // Controlador para efectos de confeti
  ConfettiController _controller = ConfettiController();

  // Getter público para el controlador de confeti
  ConfettiController get controller => _controller;

  // Getter público para copia de partidos (evita modificación externa)
  List<Match> get matches => [..._matches];

  // Getter público para copia de jugadores (evita modificación externa)
  List<Player> get players => [..._players];

  /// Añade un nuevo partido al historial
  void addMatch(Match match) {
    _matches.add(match);
    notifyListeners(); // Notifica a la UI del cambio
  }

  /// Registra un nuevo jugador
  void addPlayer(Player player) {
    _players.add(player);
    notifyListeners();
  }

  /// Limpia la lista de jugadores
  void clearPlayers() {
    _players.clear();
    notifyListeners();
  }

  /// Limpia el historial de partidos
  void clearMatches() {
    _matches.clear();
    notifyListeners();
  }

  /// Inicia el efecto de confeti
  void startConfetti() {
    _controller.play();
  }

  /// Detiene el efecto de confeti
  void stopConfetti() {
    _controller.stop();
  }

  /// Crea equipos aleatorios a partir de los jugadores registrados
  ///
  /// Devuelve: Lista con 2 equipos formados aleatoriamente
  ///
  /// Excepción: Lanza Exception si hay menos de 4 jugadores
  List<Team> createRandomTeams() {
    if (_players.length < 4) {
      throw Exception('Se necesitan al menos 4 jugadores');
    }

    _players.shuffle(); // Mezcla aleatoriamente los jugadores

    return [
      Team(
        id: DateTime.now().toString(),
        name: '',
        player1: _players[0],
        player2: _players[1],
        color: Colors.blue, // Color por defecto equipo 1
      ),
      Team(
        id: '${DateTime.now().toString()}_2',
        name: '',
        player1: _players[2],
        player2: _players[3],
        color: Colors.green, // Color por defecto equipo 2
      ),
    ];
  }
}