/// Clase que representa un jugador de pádel en la aplicación.
///
/// Esta clase modela los datos básicos de un jugador que participa en los partidos.
/// Cada jugador tiene un identificador único y un nombre que lo representa.
class Player {
  /// Identificador único del jugador.
  ///
  /// Se utiliza para distinguir de manera única a cada jugador en el sistema.
  /// Normalmente se genera automáticamente al crear el jugador.
  final String id;

  /// Nombre del jugador.
  ///
  /// Representa el nombre completo o apodo con el que se identifica al jugador.
  /// Este es el nombre que se mostrará en la interfaz de usuario.
  final String name;

  /// Constructor para crear una instancia de Jugador.
  ///
  /// Requiere:
  /// - [id]: Identificador único del jugador
  /// - [name]: Nombre del jugador (no puede estar vacío)
  ///
  /// Ejemplo de uso:
  /// ```dart
  /// Player newPlayer = Player(
  ///   id: 'unique-id-123',
  ///   name: 'Juan Pérez'
  /// );
  /// ```
  Player({
    required this.id,
    required this.name,
  });

// Nota: No se implementan métodos adicionales porque esta clase actúa
// principalmente como un modelo de datos simple (data class).
// Toda la lógica de negocio relacionada con jugadores se maneja en otras clases.
}