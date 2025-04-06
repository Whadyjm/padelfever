import 'package:flutter/material.dart';

/// Provider para gestionar los nombres de jugadores y equipos en la aplicación.
///
/// Este provider almacena y maneja:
/// - Nombres de los jugadores de ambos equipos
/// - Nombres personalizados para los equipos
/// - Notifica cambios a la interfaz de usuario
class PlayersProvider with ChangeNotifier {
  // Variables privadas para almacenamiento de estado
  String _team1Player1 = ''; // Jugador 1 del Equipo 1
  String _team1Player2 = ''; // Jugador 2 del Equipo 1
  String _team2Player1 = ''; // Jugador 1 del Equipo 2
  String _team2Player2 = ''; // Jugador 2 del Equipo 2
  String _team1 = 'Team A';  // Nombre por defecto Equipo 1
  String _team2 = 'Team B';  // Nombre por defecto Equipo 2

  // Getters públicos para acceso a los valores
  String get team1Player1 => _team1Player1;
  String get team1Player2 => _team1Player2;
  String get team2Player1 => _team2Player1;
  String get team2Player2 => _team2Player2;
  String get team1 => _team1;
  String get team2 => _team2;

  /// Métodos para actualizar los valores y notificar a los listeners

  /// Establece el nombre del Equipo 1
  void setTeam1(String name) {
    _team1 = name;
    notifyListeners(); // Notifica a los widgets suscritos
  }

  /// Establece el nombre del Equipo 2
  void setTeam2(String name) {
    _team2 = name;
    notifyListeners();
  }

  /// Establece el nombre del Jugador 1 del Equipo 1
  void setTeam1Player1(String name) {
    _team1Player1 = name;
    notifyListeners();
  }

  /// Establece el nombre del Jugador 2 del Equipo 1
  void setTeam1Player2(String name) {
    _team1Player2 = name;
    notifyListeners();
  }

  /// Establece el nombre del Jugador 1 del Equipo 2
  void setTeam2Player1(String name) {
    _team2Player1 = name;
    notifyListeners();
  }

  /// Establece el nombre del Jugador 2 del Equipo 2
  void setTeam2Player2(String name) {
    _team2Player2 = name;
    notifyListeners();
  }
}