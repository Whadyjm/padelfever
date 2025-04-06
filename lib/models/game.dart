// Enumeración que define los diferentes sistemas de juego disponibles
enum GameSystem {
  advantage,   // Sistema tradicional de ventaja (como en tenis)
  goldenPoint, // Sistema de punto de oro (gana el primero en llegar a 4 puntos)
  tieBreak     // Sistema de desempate (se activa cuando el marcador está 6-6)
}

// Clase que representa un game (juego) dentro de un partido de pádel
class Game {
  int team1Points = 0;  // Puntos acumulados por el equipo 1 en este game
  int team2Points = 0;  // Puntos acumulados por el equipo 2 en este game
  final GameSystem system;  // Sistema de juego utilizado en este game

  // Constructor que requiere especificar el sistema de juego
  Game({required this.system});

  // Método para agregar un punto a un equipo específico
  void addPoint(int team) {
    if (team == 1) {
      team1Points++;  // Incrementa puntos del equipo 1
    } else {
      team2Points++;  // Incrementa puntos del equipo 2
    }
  }

  // Método para reiniciar los puntos del game (usado al comenzar un nuevo game)
  void reset() {
    team1Points = 0;
    team2Points = 0;
  }

  // Método que determina si hay un ganador del game según el sistema de juego
  int? getWinner() {
    switch (system) {
      case GameSystem.advantage:
      // En sistema de ventaja, se necesita al menos 4 puntos y 2 de diferencia
        if (team1Points >= 4 && team1Points >= team2Points + 2) {
          return 1;  // Equipo 1 gana
        }
        if (team2Points >= 4 && team2Points >= team1Points + 2) {
          return 2;  // Equipo 2 gana
        }
        break;
      case GameSystem.goldenPoint:
      // En punto de oro, el primero en llegar a 4 puntos gana
        if (team1Points >= 4) return 1;
        if (team2Points >= 4) return 2;
        break;
      case GameSystem.tieBreak:
      // En tie-break, se necesita al menos 7 puntos y 2 de diferencia
        if (team1Points >= 7 && team1Points >= team2Points + 2) {
          return 1;
        }
        if (team2Points >= 7 && team2Points >= team1Points + 2) {
          return 2;
        }
        break;
    }
    return null;  // No hay ganador todavía
  }

  // Método que convierte los puntos numéricos a la representación tradicional
  String getScore(int points) {
    // En tie-break se muestran los puntos directamente como números
    if (system == GameSystem.tieBreak) {
      return points.toString();
    }

    // Para otros sistemas, usa la nomenclatura tradicional del tenis/pádel
    switch (points) {
      case 0: return "0";    // Cero
      case 1: return "15";   // Quince
      case 2: return "30";   // Treinta
      case 3: return "40";   // Cuarenta
      default: return "AD";  // Ventaja (Advantage)
    }
  }
}