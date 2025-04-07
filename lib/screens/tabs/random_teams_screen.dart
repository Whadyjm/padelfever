import 'package:flutter/material.dart';
import 'package:padelpoint/theme/colors.dart';
import 'package:padelpoint/widgets/appBtn.dart';
import 'package:padelpoint/widgets/publicidadWidget.dart';
import 'package:provider/provider.dart';
import '../../models/game.dart';
import '../../models/player.dart';
import '../../providers/match_provider.dart';
import '../../theme/text.dart';
import '../../widgets/PlayersTextField.dart';
import '../match_screen.dart';

/// Pantalla para crear equipos aleatorios a partir de una lista de jugadores
class RandomTeamsScreen extends StatefulWidget {
  static const routeName = '/random-teams'; // Ruta de navegación
  const RandomTeamsScreen({super.key}); // Constructor

  @override
  _RandomTeamsScreenState createState() => _RandomTeamsScreenState(); // Crea el estado
}

class _RandomTeamsScreenState extends State<RandomTeamsScreen> {
  final _playerController = TextEditingController(); // Controlador para el campo de jugador
  final List<Player> _players = []; // Lista de jugadores agregados
  GameSystem _gameSystem = GameSystem.advantage; // Sistema de juego seleccionado

  /// Agrega un nuevo jugador a la lista
  void _addPlayer() {
    if (_playerController.text.isEmpty) return; // No hacer nada si el campo está vacío

    setState(() {
      _players.add(
        Player(
          id: DateTime.now().toString(), // ID único basado en timestamp
          name: _playerController.text, // Nombre del jugador
        ),
      );
      _playerController.clear(); // Limpia el campo de texto
    });
  }

  /// Elimina un jugador de la lista
  void _removePlayer(Player player) {
    setState(() {
      _players.remove(player); // Remueve el jugador especificado
    });
  }

  /// Crea equipos aleatorios y navega a la pantalla de partido
  void _createTeams() {
    // Validación: mínimo 4 jugadores
    if (_players.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Se necesitan al menos 4 jugadores')),
      );
      return;
    }

    // Prepara los jugadores en el provider
    final provider = Provider.of<MatchProvider>(context, listen: false);
    provider.clearPlayers(); // Limpia jugadores existentes

    // Agrega todos los jugadores actuales
    for (var player in _players) {
      provider.addPlayer(player);
    }

    // Crea equipos aleatorios
    final teams = provider.createRandomTeams();

    // Navega a la pantalla de partido con los equipos generados
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MatchScreen(
          team1: teams[0],
          team2: teams[1],
          gameSystem: _gameSystem,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _playerController.dispose(); // Limpia el controlador
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final matchProvider = Provider.of<MatchProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Widget de publicidad
            PublicidadWidget(),
            const SizedBox(height: 20),

            // Fila para agregar jugadores
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Campo de texto para nombre del jugador
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 120,
                  child: PlayersTextField(
                    nombre: _playerController,
                    hintText: 'Nombre del jugador',
                  ),
                ),

                // Contador de jugadores (solo si hay jugadores)
                _players.isEmpty
                    ? const SizedBox.shrink()
                    : Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Text(
                    '${_players.length}',
                    style: AppText.smallTextStyle(Colors.grey.shade700),
                  ),
                ),

                // Botón para agregar jugador
                FloatingActionButton(
                  mini: true,
                  elevation: 0,
                  backgroundColor: AppColors.primaryColorLight,
                  onPressed: _addPlayer,
                  child: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // Lista de jugadores o mensaje si está vacía
            _players.isEmpty
                ? Text(
              'No hay jugadores agregados',
              style: AppText.smallTextStyle(Colors.grey.shade500),
            )
                : Column(
              children: _players
                  .map(
                    (player) => ListTile(
                  title: Text(
                    player.name,
                    style: AppText.smallTextStyle(
                      Colors.grey.shade700,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.redAccent,
                    ),
                    onPressed: () => _removePlayer(player),
                  ),
                ),
              )
                  .toList(),
            ),

            const SizedBox(height: 20),

            // Selector de sistema de juego
            Row(
              children: [
                Text(
                  'Sistema de juego',
                  style: AppText.subtitleStyle(Colors.grey.shade700),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Divider(color: Colors.grey.shade300, thickness: 0.8),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Opción: Sistema de ventaja
            RadioListTile<GameSystem>(
              hoverColor: Colors.transparent,
              activeColor: AppColors.primaryColorLight,
              title: Text(
                'Sistema de ventaja',
                style: AppText.smallTextStyle(Colors.grey.shade700),
              ),
              value: GameSystem.advantage,
              groupValue: _gameSystem,
              onChanged: (value) {
                setState(() {
                  _gameSystem = value!;
                });
              },
            ),

            // Opción: Punto de oro
            RadioListTile<GameSystem>(
              hoverColor: Colors.transparent,
              activeColor: Colors.amber,
              title: Text(
                'Punto de oro',
                style: AppText.smallTextStyle(Colors.grey.shade700),
              ),
              value: GameSystem.goldenPoint,
              groupValue: _gameSystem,
              onChanged: (value) {
                setState(() {
                  _gameSystem = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            // Botón para comenzar partido (habilitado solo con 4+ jugadores)
            AppBtn(
              isEnabled: _players.length >= 4,
              text: 'Comenzar partido',
              onPressed: _createTeams,
            ),
          ],
        ),
      ),
    );
  }
}