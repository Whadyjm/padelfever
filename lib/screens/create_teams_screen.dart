import 'package:flutter/material.dart';
import 'package:padelpoint/theme/colors.dart';
import 'package:padelpoint/widgets/PlayersTextField.dart';
import '../models/game.dart';
import '../models/player.dart' show Player;
import '../models/team.dart' show Team;
import '../theme/text.dart';
import '../widgets/appBtn.dart';
import 'match_screen.dart';

class CreateTeamsScreen extends StatefulWidget {
  static const routeName = '/create-teams';
  const CreateTeamsScreen({super.key});

  @override
  _CreateTeamsScreenState createState() => _CreateTeamsScreenState();
}

class _CreateTeamsScreenState extends State<CreateTeamsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _team1NameController = TextEditingController(text: 'Team A');
  final _team2NameController = TextEditingController(text: 'Team B');
  final _team1Player1Controller = TextEditingController();
  final _team1Player2Controller = TextEditingController();
  final _team2Player1Controller = TextEditingController();
  final _team2Player2Controller = TextEditingController();
  GameSystem _gameSystem = GameSystem.advantage;

  @override
  void dispose() {
    _team1NameController.dispose();
    _team2NameController.dispose();
    _team1Player1Controller.dispose();
    _team1Player2Controller.dispose();
    _team2Player1Controller.dispose();
    _team2Player2Controller.dispose();
    super.dispose();
  }

  void _startMatch() {
    final team1 = Team(
      id: DateTime.now().toString(),
      name: _team1NameController.text,
      player1: Player(id: '1', name: _team1Player1Controller.text),
      player2: Player(id: '2', name: _team1Player2Controller.text),
    );

    final team2 = Team(
      id: DateTime.now().toString() + '2',
      name: _team2NameController.text,
      player1: Player(id: '3', name: _team2Player1Controller.text),
      player2: Player(id: '4', name: _team2Player2Controller.text),
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (ctx) => MatchScreen(
              team1: team1,
              team2: team2,
              gameSystem: _gameSystem,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Team 1
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  controller: _team1NameController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.edit, size: 20),
                    border: InputBorder.none,
                    hintText: "Ingresa el nombre del equipo A (opcional)",
                  ),
                  style: AppText.subtitleStyle(Colors.grey.shade700),
                ),
              ),
              PlayersTextField(
                nombre: _team1Player1Controller,
                hintText: 'Nombre de jugador 1',
              ),
              PlayersTextField(
                nombre: _team1Player2Controller,
                hintText: 'Nombre de jugador 2',
              ),
              const SizedBox(height: 20),

              // Team 2
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: TextField(
                  controller: _team2NameController,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.edit, size: 20),
                    border: InputBorder.none,
                    hintText: "Ingresa el nombre del equipo B (opcional)",
                  ),
                  style: AppText.subtitleStyle(Colors.grey.shade700),
                ),
              ),
              PlayersTextField(
                nombre: _team2Player1Controller,
                hintText: 'Nombre de jugador 1',
              ),
              PlayersTextField(
                nombre: _team2Player2Controller,
                hintText: 'Nombre de jugador 2',
              ),
              const SizedBox(height: 20),
              // Game system
              Text(
                'Sistema de juego',
                style: AppText.subtitleStyle(Colors.grey.shade700),
              ),
              RadioListTile<GameSystem>(
                hoverColor: Colors.transparent,
                activeColor: AppColors.primaryColorLight,
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
                hoverColor: Colors.transparent,
                activeColor: Colors.amber,
                title: const Text('Punto de oro'),
                value: GameSystem.goldenPoint,
                groupValue: _gameSystem,
                onChanged: (value) {
                  setState(() {
                    _gameSystem = value!;
                  });
                },
              ),
              const SizedBox(height: 50),

              // Start button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppBtn(text: 'Comenzar partido', onPressed: _startMatch),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
