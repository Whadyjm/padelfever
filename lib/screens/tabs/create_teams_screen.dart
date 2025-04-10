// Pantalla para crear equipos antes de comenzar un partido de pádel
// Permite configurar nombres de equipos, jugadores, colores y sistema de juego

// Dependencias para animaciones, estilos y componentes UI
import 'package:animate_do/animate_do.dart';
import 'package:blur/blur.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// Importaciones locales: temas, widgets y modelos
import 'package:padelpoint/theme/colors.dart';
import 'package:padelpoint/widgets/PlayersTextField.dart';
import 'package:padelpoint/widgets/addPlayersSection.dart';
import 'package:padelpoint/widgets/publicidadWidget.dart';
import 'package:provider/provider.dart';
import '../../models/game.dart';
import '../../models/player.dart' show Player;
import '../../models/team.dart' show Team;
import '../../providers/btn_provider.dart';
import '../../providers/colors_provider.dart';
import '../../providers/players_provider.dart';
import '../../theme/text.dart';
import '../../widgets/appBtn.dart';
import '../../widgets/teamNameTextField.dart';
import '../match_screen.dart';

// Widget Stateful que representa la pantalla de creación de equipos
class CreateTeamsScreen extends StatefulWidget {
  static const routeName = '/create-teams'; // Ruta de navegación
  const CreateTeamsScreen({super.key}); // Constructor

  @override
  _CreateTeamsScreenState createState() => _CreateTeamsScreenState(); // Crea el estado
}

// Estado de la pantalla de creación de equipos
class _CreateTeamsScreenState extends State<CreateTeamsScreen> {
  // Controladores para los campos de texto del formulario
  final _formKey = GlobalKey<FormState>(); // Key para validación de formulario
  final _team1NameController = TextEditingController(); // Controlador nombre equipo 1
  final _team2NameController = TextEditingController(); // Controlador nombre equipo 2
  final _team1Player1Controller = TextEditingController(); // Controlador jugador 1 equipo 1
  final _team1Player2Controller = TextEditingController(); // Controlador jugador 2 equipo 1
  final _team2Player1Controller = TextEditingController(); // Controlador jugador 1 equipo 2
  final _team2Player2Controller = TextEditingController(); // Controlador jugador 2 equipo 2

  // Estados internos del widget
  bool team1Ready = false; // Indica si equipo 1 está completo
  bool team2Ready = false; // Indica si equipo 2 está completo
  GameSystem _gameSystem = GameSystem.advantage; // Sistema de juego seleccionado
  Color _team1Color = Colors.blue; // Color del equipo 1
  Color _team2Color = Colors.green; // Color del equipo 2

  @override
  void initState() {
    super.initState();

    // Obtiene el provider de jugadores
    final playersProvider = Provider.of<PlayersProvider>(
      context,
      listen: false,
    );

    // Configura listeners para actualizar estado de botones
    _team1Player1Controller.addListener(_updateButtonColor);
    _team1Player2Controller.addListener(_updateButtonColor);
    _team2Player1Controller.addListener(_updateButtonColor);
    _team2Player2Controller.addListener(_updateButtonColor);

    // Inicializa los controladores con valores del provider
    _team1NameController.text = playersProvider.team1;
    _team2NameController.text = playersProvider.team2;
    _team1Player1Controller.text = playersProvider.team1Player1;
    _team1Player2Controller.text = playersProvider.team1Player2;
    _team2Player1Controller.text = playersProvider.team2Player1;
    _team2Player2Controller.text = playersProvider.team2Player2;

    // Configura listeners para sincronizar con el provider
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
  }

  // Actualiza el estado para reflejar cambios en los campos
  void _updateButtonColor() {
    setState(() {});
  }

  @override
  void dispose() {
    // Limpieza de listeners y controladores
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

  // Muestra diálogo para seleccionar color del equipo 1
  void _pickColorTeam1(Color currentColor, onColorChanged) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Elige un color',
            style: AppText.subtitleStyle(Colors.grey.shade700),
          ),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: currentColor,
              onColorChanged: onColorChanged,
              availableColors: [
                Colors.blue,
                Colors.red,
                Colors.green,
                Colors.yellow,
                Colors.purple,
                Colors.orange,
                Colors.teal,
                Colors.brown,
                Colors.grey,
                Colors.pink,
                Colors.cyan,
                Colors.lime,
                Colors.indigo,
                Colors.amber,
                Colors.deepOrange,
                Colors.lightGreen,
                Colors.deepPurple,
                Colors.lightBlue,
                Colors.black,
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: Text(
                  'Seleccionar',
                  style: AppText.subtitleStyle(Colors.blue),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Muestra diálogo para seleccionar color del equipo 2
  void _pickColorTeam2(Color currentColor, onColorChanged) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          title: Text(
            'Elige un color',
            style: AppText.subtitleStyle(Colors.grey.shade700),
          ),
          content: SingleChildScrollView(
            child: BlockPicker(
              pickerColor: currentColor,
              onColorChanged: onColorChanged,
              availableColors: [
                Colors.blue,
                Colors.red,
                Colors.green,
                Colors.yellow,
                Colors.purple,
                Colors.orange,
                Colors.teal,
                Colors.brown,
                Colors.grey,
                Colors.pink,
                Colors.cyan,
                Colors.lime,
                Colors.indigo,
                Colors.amber,
                Colors.deepOrange,
                Colors.lightGreen,
                Colors.deepPurple,
                Colors.lightBlue,
                Colors.black,
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Center(
                child: Text(
                  'Seleccionar',
                  style: AppText.subtitleStyle(Colors.blue),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Obtiene los providers necesarios
    final btnProvider = Provider.of<BtnProvider>(context);
    final colorsProvider = Provider.of<ColorsProvider>(context);

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Widget de publicidad
            PublicidadWidget(),
            const SizedBox(height: 20),

            // Configuración del equipo 1
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Campo para nombre del equipo 1
                TeamNameTextField(
                  controller: _team1NameController,
                  hintText: 'Ingresa el nombre del equipo A (opcional)',
                ),

                // Selector de color para equipo 1
                GestureDetector(
                  onTap: () {
                    _pickColorTeam1(_team1Color, (color) {
                      setState(() {
                        _team1Color = color;
                      });
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: _team1Color,
                    ),
                  ),
                ),

                // Indicador visual de equipo completo
                SizedBox(
                  height: 30,
                  width: 50,
                  child: FloatingActionButton(
                    elevation: 0,
                    backgroundColor:
                    (_team1Player1Controller.text.isNotEmpty &&
                        _team1Player2Controller.text.isNotEmpty)
                        ? AppColors.secondaryColorLight
                        : Colors.grey.shade300,
                    onPressed: () {},
                    child: Icon(Icons.check, color: Colors.white),
                  ),
                ),

                // Sección para agregar jugadores al equipo 1
                AddPlayersSection(
                  controller1: _team1Player1Controller,
                  controller2: _team1Player2Controller,
                  showTextField: btnProvider.showTextField1,
                  toggleTextfield: btnProvider.toggleTextField1,
                ),
              ],
            ),

            // Campos para jugadores del equipo 1 (visibles condicionalmente)
            Visibility(
              visible: btnProvider.showTextField1,
              child: FadeInRight(
                duration: const Duration(milliseconds: 800),
                animate: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PlayersTextField(
                      nombre: _team1Player1Controller,
                      hintText: 'Jugador 1',
                    ),
                    const SizedBox(height: 20),
                    PlayersTextField(
                      nombre: _team1Player2Controller,
                      hintText: 'Jugador 2',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Configuración del equipo 2 (similar al equipo 1)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TeamNameTextField(
                  controller: _team2NameController,
                  hintText: 'Ingresa el nombre del equipo B (opcional)',
                ),
                GestureDetector(
                  onTap: () {
                    _pickColorTeam2(_team2Color, (color) {
                      setState(() {
                        _team2Color = color;
                      });
                    });
                  },
                  child: Container(
                    height: 30,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: _team2Color,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: 50,
                  child: FloatingActionButton(
                    elevation: 0,
                    backgroundColor:
                    (_team2Player1Controller.text.isNotEmpty &&
                        _team2Player2Controller.text.isNotEmpty)
                        ? AppColors.secondaryColorLight
                        : Colors.grey.shade300,
                    onPressed: () {},
                    child: Icon(Icons.check, color: Colors.white),
                  ),
                ),
                AddPlayersSection(
                  controller1: _team2Player1Controller,
                  controller2: _team2Player2Controller,
                  showTextField: btnProvider.showTextField2,
                  toggleTextfield: btnProvider.toggleTextField2,
                ),
              ],
            ),
            Visibility(
              visible: btnProvider.showTextField2,
              child: FadeInRight(
                duration: const Duration(milliseconds: 800),
                animate: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PlayersTextField(
                      nombre: _team2Player1Controller,
                      hintText: 'Jugador 1',
                    ),
                    const SizedBox(height: 20),
                    PlayersTextField(
                      nombre: _team2Player2Controller,
                      hintText: 'Jugador 2',
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Selección del sistema de juego
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

            // Botón para comenzar el partido
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
                  onPressed: () {
                    // Guarda los colores seleccionados
                    colorsProvider.team1Color = _team1Color;
                    colorsProvider.team2Color = _team2Color;

                    // Crea los equipos con la configuración actual
                    final team1 = Team(
                      id: DateTime.now().toString(),
                      name: _team1NameController.text,
                      player1: Player(
                        id: '1',
                        name: _team1Player1Controller.text,
                      ),
                      player2: Player(
                        id: '2',
                        name: _team1Player2Controller.text,
                      ),
                      color: _team1Color,
                    );

                    final team2 = Team(
                      id: DateTime.now().toString() + '2',
                      name: _team2NameController.text,
                      player1: Player(
                        id: '3',
                        name: _team2Player1Controller.text,
                      ),
                      player2: Player(
                        id: '4',
                        name: _team2Player2Controller.text,
                      ),
                      color: _team2Color,
                    );

                    // Navega a la pantalla de partido
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
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}