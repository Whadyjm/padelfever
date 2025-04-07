// Importación de librerías necesarias
import 'dart:ui'; // Para usar la clase Color
import 'package:padelpoint/models/player.dart'; // Para usar la clase Player

/// Clase que representa un equipo en un partido de pádel.
///
/// Un equipo está compuesto por dos jugadores (player1 y player2),
/// puede tener un nombre opcional y un color identificativo.
class Team {
  /// Identificador único del equipo
  final String id;

  /// Nombre del equipo (opcional)
  ///
  /// Si está vacío, se usará la combinación de nombres de los jugadores
  final String name;

  /// Primer jugador del equipo
  final Player player1;

  /// Segundo jugador del equipo
  final Player player2;

  /// Color representativo del equipo
  ///
  /// Se utiliza para distinguir visualmente a los equipos en la interfaz
  final Color color;

  /// Constructor del equipo
  ///
  /// Requiere:
  /// - [id]: Identificador único
  /// - [name]: Nombre del equipo (puede ser vacío)
  /// - [player1]: Primer jugador
  /// - [player2]: Segundo jugador
  /// - [color]: Color representativo
  Team({
    required this.id,
    required this.name,
    required this.player1,
    required this.player2,
    required this.color,
  });

  /// Getter que devuelve el nombre a mostrar para el equipo
  ///
  /// Si [name] no está vacío, lo devuelve.
  /// Si [name] está vacío, devuelve la combinación de nombres de los jugadores
  /// en formato "Jugador1 - Jugador2"
  String get teamName => name.isEmpty
      ? 'Team A - Team B'
      : name;
}
