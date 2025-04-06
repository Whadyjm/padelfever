import 'dart:ui'; // Para acceso a la clase Color básica
import 'package:flutter/material.dart'; // Para usar los colores de Material Design

/// Provider para gestionar los colores de los equipos en la aplicación.
///
/// Este provider permite:
/// 1. Almacenar los colores seleccionados para cada equipo
/// 2. Modificar estos colores de forma reactiva
/// 3. Notificar a la interfaz cuando los colores cambian
class ColorsProvider with ChangeNotifier {
  // Color actual del equipo 1 (privado)
  Color _team1Color = Colors.blue;

  // Color actual del equipo 2 (privado)
  Color _team2Color = Colors.green;

  /// Getter para obtener el color del equipo 1
  Color get team1Color => _team1Color;

  /// Getter para obtener el color del equipo 2
  Color get team2Color => _team2Color;

  /// Setter para cambiar el color del equipo 1
  ///
  /// Parámetros:
  /// - [color]: Nuevo color a asignar (tipo Color)
  ///
  /// Efectos:
  /// - Actualiza el estado interno
  /// - Notifica a los listeners del cambio
  set team1Color(Color color) {
    _team1Color = color;
    notifyListeners(); // Notifica a los widgets suscritos
  }

  /// Setter para cambiar el color del equipo 2
  ///
  /// Parámetros:
  /// - [color]: Nuevo color a asignar (tipo Color)
  ///
  /// Efectos:
  /// - Actualiza el estado interno
  /// - Notifica a los listeners del cambio
  set team2Color(Color color) {
    _team2Color = color;
    notifyListeners(); // Notifica a los widgets suscritos
  }
}