// Importaciones necesarias
import 'package:padelpoint/models/game.dart';  // Para usar la clase Game y GameSystem
import 'package:padelpoint/models/team.dart';  // Para usar la clase Team

// Clase que representa un partido completo de pádel
class Match {
  // Identificador único del partido
  final String id;

  // Fecha y hora en que se creó el partido
  final DateTime date;

  // Primer equipo participante
  final Team team1;

  // Segundo equipo participante
  final Team team2;

  // Sistema de juego seleccionado para el partido
  final GameSystem gameSystem;

  // Lista de games ganados por el equipo 1 (cada elemento representa 1 game ganado)
  List<int> team1Games = [];

  // Lista de games ganados por el equipo 2 (cada elemento representa 1 game ganado)
  List<int> team2Games = [];

  // Game actual que se está jugando
  Game currentGame;

  // Constructor del partido
  Match({
    required this.id,
    required this.team1,
    required this.team2,
    required this.gameSystem,
  })  : date = DateTime.now(),  // Asigna la fecha/hora actual al crear el partido
        currentGame = Game(system: gameSystem);  // Crea el primer game con el sistema seleccionado

  // Método para registrar un game ganado por un equipo
  void addGame(int winner) {
    if (winner == 1) {
      team1Games.add(1);  // Añade un game al equipo 1
    } else {
      team2Games.add(1);  // Añade un game al equipo 2
    }

    // Lógica para activar el tie-break cuando ambos equipos tienen 6 games
    if (team1Games.length == 6 && team2Games.length == 6) {
      currentGame = Game(system: GameSystem.tieBreak);  // Crea un nuevo game con sistema tie-break
    } else {
      currentGame = Game(system: gameSystem);  // Crea un nuevo game con el sistema original
    }
  }

  // Getter que devuelve el total de games ganados por el equipo 1
  int get team1TotalGames => team1Games.length;

  // Getter que devuelve el total de games ganados por el equipo 2
  int get team2TotalGames => team2Games.length;

  // Getter que determina si hay un ganador del partido
  String get winner {
    // Verifica victoria normal (6 games con diferencia de 2)
    if (team1TotalGames >= 6 && team1TotalGames >= team2TotalGames + 2) {
      return team1.teamName;  // Retorna nombre del equipo 1 como ganador
    }
    if (team2TotalGames >= 6 && team2TotalGames >= team1TotalGames + 2) {
      return team2.teamName;  // Retorna nombre del equipo 2 como ganador
    }

    // Verifica victoria por tie-break (7-6)
    if (team1TotalGames == 7 && team2TotalGames == 6) {
      return team1.teamName;  // Equipo 1 gana por tie-break
    }
    if (team2TotalGames == 7 && team1TotalGames == 6) {
      return team2.teamName;  // Equipo 2 gana por tie-break
    }

    return '';  // Retorna string vacío si no hay ganador aún
  }
}