import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import '../models/player.dart';
import '../providers/match_provider.dart';
import 'match_screen.dart';

class RandomTeamsScreen extends StatefulWidget {
  static const routeName = '/random-teams';
  const RandomTeamsScreen({super.key});

  @override
  _RandomTeamsScreenState createState() => _RandomTeamsScreenState();
}

class _RandomTeamsScreenState extends State<RandomTeamsScreen> {
  final _playerController = TextEditingController();
  final List<Player> _players = [];
  GameSystem _gameSystem = GameSystem.advantage;

  void _addPlayer() {
    if (_playerController.text.isEmpty) return;

    setState(() {
      _players.add(Player(
        id: DateTime.now().toString(),
        name: _playerController.text,
      ));
      _playerController.clear();
    });
  }

  void _removePlayer(Player player) {
    setState(() {
      _players.remove(player);
    });
  }

  void _createTeams() {
    if (_players.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Se necesitan al menos 4 jugadores'),
        ),
      );
      return;
    }

    final provider = Provider.of<MatchProvider>(context, listen: false);
    provider.clearPlayers();
    for (var player in _players) {
      provider.addPlayer(player);
    }

    final teams = provider.createRandomTeams();

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
    _playerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipos aleatorios'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Add players
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _playerController,
                    decoration: const InputDecoration(labelText: 'Nombre del jugador'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addPlayer,
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Jugadores agregados:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _players.isEmpty
                ? const Text('No hay jugadores agregados')
                : Column(
              children: _players
                  .map(
                    (player) => ListTile(
                  title: Text(player.name),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _removePlayer(player),
                  ),
                ),
              )
                  .toList(),
            ),
            const SizedBox(height: 20),

            // Game system
            const Text(
              'Sistema de juego',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            RadioListTile<GameSystem>(
              title: const Text('Sistema de ventaja'),
              value: GameSystem.advantage,
              groupValue: _gameSystem,
              onChanged: (value) {
                setState(() {
                  _gameSystem = value!;
                });
              },
            ),
            RadioListTile<GameSystem>(
              title: const Text('Punto de oro'),
              value: GameSystem.goldenPoint,
              groupValue: _gameSystem,
              onChanged: (value) {
                setState(() {
                  _gameSystem = value!;
                });
              },
            ),
            const SizedBox(height: 20),

            // Create teams button
            ElevatedButton(
              onPressed: _createTeams,
              child: const Text('Crear equipos aleatorios'),
            ),
          ],
        ),
      ),
    );
  }
}