import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:padelpoint/theme/colors.dart';
import 'package:padelpoint/widgets/PlayersTextField.dart';
import 'package:padelpoint/widgets/addPlayersSection.dart';
import 'package:provider/provider.dart';
import '../models/game.dart';
import '../models/player.dart' show Player;
import '../models/team.dart' show Team;
import '../providers/btn_provider.dart';
import '../providers/players_provider.dart';
import '../theme/text.dart';
import '../widgets/appBtn.dart';
import '../widgets/teamNameTextField.dart';
import 'match_screen.dart';

class CreateTeamsScreen extends StatefulWidget {
  static const routeName = '/create-teams';
  const CreateTeamsScreen({super.key});

  @override
  _CreateTeamsScreenState createState() => _CreateTeamsScreenState();
}

class _CreateTeamsScreenState extends State<CreateTeamsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _team1NameController = TextEditingController();
  final _team2NameController = TextEditingController();
  final _team1Player1Controller = TextEditingController();
  final _team1Player2Controller = TextEditingController();
  final _team2Player1Controller = TextEditingController();
  final _team2Player2Controller = TextEditingController();
  bool team1Ready = false;
  bool team2Ready = false;
  GameSystem _gameSystem = GameSystem.advantage;

  @override
  void initState() {
    final playersProvider = Provider.of<PlayersProvider>(
      context,
      listen: false,
    );

    _team1Player1Controller.addListener(_updateButtonColor);
    _team1Player2Controller.addListener(_updateButtonColor);
    _team2Player1Controller.addListener(_updateButtonColor);
    _team2Player2Controller.addListener(_updateButtonColor);

    _team1NameController.text = playersProvider.team1;
    _team2NameController.text = playersProvider.team2;
    _team1Player1Controller.text = playersProvider.team1Player1;
    _team1Player2Controller.text = playersProvider.team1Player2;
    _team2Player1Controller.text = playersProvider.team2Player1;
    _team2Player2Controller.text = playersProvider.team2Player2;

    _team1NameController.addListener(() {
      playersProvider.setTeam1(_team1NameController.text);
    });
    _team2NameController.addListener(() {
      playersProvider.setTeam2(_team2NameController.text);
    });
    _team1Player1Controller.addListener(() {
      playersProvider.setTeam1Player1(_team1Player1Controller.text);
    });
    _team1Player2Controller.addListener(() {
      playersProvider.setTeam1Player2(_team1Player2Controller.text);
    });
    _team2Player1Controller.addListener(() {
      playersProvider.setTeam2Player1(_team2Player1Controller.text);
    });
    _team2Player2Controller.addListener(() {
      playersProvider.setTeam2Player2(_team2Player2Controller.text);
    });
    super.initState();
  }

  void _updateButtonColor() {
    setState(() {});
  }

  @override
  void dispose() {
    _team1Player1Controller.removeListener(_updateButtonColor);
    _team1Player2Controller.removeListener(_updateButtonColor);
    _team2Player1Controller.removeListener(_updateButtonColor);
    _team2Player2Controller.removeListener(_updateButtonColor);
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
    final btnProvider = Provider.of<BtnProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Team 1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      TeamNameTextField(
                        controller: _team1NameController,
                        hintText: 'Ingresa el nombre del equipo A (opcional)',
                      ),
                      Visibility(
                        visible: btnProvider.showTextField1 ? true : false,
                        child: FadeInRight(
                          duration: const Duration(milliseconds: 800),
                          animate: true,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PlayersTextField(
                                nombre: _team1Player1Controller,
                                hintText: 'Jugador 1',
                              ),
                              PlayersTextField(
                                nombre: _team1Player2Controller,
                                hintText: 'Jugador 2',
                              ),
                              const SizedBox(width: 20),
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: FloatingActionButton(
                                  elevation: 0,
                                  backgroundColor:
                                      (_team1Player1Controller
                                                  .text
                                                  .isNotEmpty &&
                                              _team1Player2Controller
                                                  .text
                                                  .isNotEmpty)
                                          ? AppColors.secondaryColorLight
                                          : Colors.grey.shade300,
                                  onPressed: () {},
                                  child: Icon(Icons.check, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  AddPlayersSection(
                    controller1: _team1Player1Controller,
                    controller2: _team1Player2Controller,
                    showTextField: btnProvider.showTextField1,
                    toggleTextfield: btnProvider.toggleTextField1,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Team 2
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      TeamNameTextField(
                        controller: _team2NameController,
                        hintText: 'Ingresa el nombre del equipo B (opcional)',
                      ),
                      Visibility(
                        visible: btnProvider.showTextField2 ? true : false,
                        child: FadeInRight(
                          duration: const Duration(milliseconds: 800),
                          animate: true,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              PlayersTextField(
                                nombre: _team2Player1Controller,
                                hintText: 'Jugador 1',
                              ),
                              PlayersTextField(
                                nombre: _team2Player2Controller,
                                hintText: 'Jugador 2',
                              ),
                              const SizedBox(width: 20),
                              SizedBox(
                                height: 40,
                                width: 40,
                                child: FloatingActionButton(
                                  elevation: 0,
                                  backgroundColor:
                                      (_team2Player1Controller
                                                  .text
                                                  .isNotEmpty &&
                                              _team2Player2Controller
                                                  .text
                                                  .isNotEmpty)
                                          ? AppColors.secondaryColorLight
                                          : Colors.grey.shade300,
                                  onPressed: () {},
                                  child: Icon(Icons.check, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  AddPlayersSection(
                    controller1: _team2Player1Controller,
                    controller2: _team2Player2Controller,
                    showTextField: btnProvider.showTextField2,
                    toggleTextfield: btnProvider.toggleTextField2,
                  ),
                ],
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
              const SizedBox(height: 50),
              // Start button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppBtn(
                    isEnabled:
                        (_team1Player1Controller.text.isNotEmpty &&
                                _team1Player2Controller.text.isNotEmpty &&
                                _team2Player1Controller.text.isNotEmpty &&
                                _team2Player2Controller.text.isNotEmpty)
                            ? true
                            : false,
                    text: 'Comenzar partido',
                    onPressed: _startMatch,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
