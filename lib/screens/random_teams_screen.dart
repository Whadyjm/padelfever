import 'package:flutter/material.dart';
import 'package:padelpoint/theme/colors.dart';
import 'package:padelpoint/widgets/appBtn.dart';
import 'package:padelpoint/widgets/publicidadWidget.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import '../models/player.dart';
import '../providers/match_provider.dart';
import '../theme/text.dart';
import '../widgets/PlayersTextField.dart';
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
      _players.add(
        Player(id: DateTime.now().toString(), name: _playerController.text),
      );
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
        const SnackBar(content: Text('Se necesitan al menos 4 jugadores')),
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
        builder:
            (ctx) => MatchScreen(
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
    final matchProvider = Provider.of<MatchProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            PublicidadWidget(),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.sizeOf(context).width - 120,
                  child: PlayersTextField(
                    nombre: _playerController,
                    hintText: 'Nombre del jugador',
                  ),
                ),
                _players.isEmpty
                    ? const SizedBox.shrink()
                    : Padding(
                      padding: const EdgeInsets.only(right: 2),
                      child: Text(
                        '${_players.length}',
                        style: AppText.smallTextStyle(Colors.grey.shade700),
                      ),
                    ),
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
            _players.isEmpty
                ? Text(
                  'No hay jugadores agregados',
                  style: AppText.smallTextStyle(Colors.grey.shade500),
                )
                : Column(
                  children:
                      _players
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
            // Game system
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

            AppBtn(
              isEnabled: _players.length >= 4 ? true : false,
              text: 'Comenzar partido',
              onPressed: _createTeams,
            ),
          ],
        ),
      ),
    );
  }
}
