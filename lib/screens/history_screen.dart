import 'package:flutter/material.dart';
import 'package:padelpoint/providers/colors_provider.dart';
import 'package:provider/provider.dart';
import '../alertDialogs/authAlertDialogs/emptyFieldsDialog.dart';
import '../providers/btn_provider.dart';
import '../providers/match_provider.dart';
import '../theme/colors.dart';
import '../theme/text.dart';
import '../widgets/authWidgets/authTextField.dart';

/// Pantalla que muestra el historial de partidos jugados
class HistoryScreen extends StatefulWidget {
  static const routeName = '/history'; // Ruta de navegación
  const HistoryScreen({super.key});
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
 // Constructor
  @override
  Widget build(BuildContext context) {
    TextEditingController userController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    bool _isLoading = false; // Estado de carga para el registro
    // Obtiene la lista de partidos del provider
    final matches = Provider.of<MatchProvider>(context).matches;
    final btnProvider = Provider.of<BtnProvider>(context);

    /// Muestra un diálogo de confirmación para limpiar el historial
    void _clearConfirmation() {
      showDialog(
        context: context,
        barrierDismissible: false, // Obliga al usuario a tomar acción
        builder:
            (ctx) => AlertDialog(
              backgroundColor: Colors.white,
              title: Center(
                child: Text(
                  'Confirmación',
                  style: AppText.titleStyle(Colors.grey.shade800),
                ),
              ),
              content: Text(
                '¿Seguro desea limpiar el historial de partidos?',
                style: AppText.subtitleStyle(Colors.grey.shade700),
              ),
              actions: [
                // Botón para confirmar limpieza
                TextButton(
                  onPressed: () {
                    final provider = Provider.of<MatchProvider>(
                      context,
                      listen: false,
                    );
                    provider.clearMatches(); // Limpia los partidos
                    Navigator.of(ctx).pop(); // Cierra el diálogo
                  },
                  child: Center(
                    child: Text(
                      'Continuar',
                      style: AppText.subtitleStyle(Colors.blue),
                    ),
                  ),
                ),
                const Divider(), // Separador visual
                // Botón para cancelar
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop(); // Cierra el diálogo
                  },
                  child: Center(
                    child: Text(
                      'Cancelar',
                      style: AppText.subtitleStyle(Colors.redAccent),
                    ),
                  ),
                ),
              ],
            ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColorLight, // Color de la app bar
        centerTitle: true, // Centra el título
        // Botón de retroceso
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        ),
        title: Text(
          'Historial de partidos',
          style: AppText.titleStyle(Colors.white),
        ),
        // Botón para limpiar historial (deshabilitado si no hay partidos)
        actions: [
          IconButton(
            onPressed: () => matches.isEmpty ? null : _clearConfirmation(),
            icon: Icon(Icons.delete, color: Colors.white),
          ),
        ],
      ),
      // Cuerpo de la pantalla
      body:
          btnProvider.isGuest
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder:
                                    (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(12)),
                                  ),
                                  backgroundColor: Colors.white,
                                  content: SizedBox(
                                    height: 300,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              onPressed: () => Navigator.pop(context),
                                              icon: Icon(
                                                Icons.close_rounded,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Registro',
                                          style: AppText.titleStyle(
                                            AppColors.primaryColorLight,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        AuthTextField(
                                          nombre: userController,
                                          hintText: 'Usuario',
                                        ),
                                        const SizedBox(height: 10),
                                        AuthTextField(
                                          nombre: emailController,
                                          hintText: 'Email',
                                        ),
                                        const SizedBox(height: 10),
                                        AuthTextField(
                                          hidePassword: true,
                                          nombre: passwordController,
                                          hintText: 'Contraseña',
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    Center(
                                      child: StatefulBuilder(
                                        builder:
                                            (
                                            BuildContext context,
                                            void Function(void Function()) setState,
                                            ) => MaterialButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          height: 50,
                                          minWidth: 200,
                                          color: AppColors.primaryColorLight,
                                          onPressed: () async {
                                            if (userController.text.isEmpty || emailController.text.isEmpty ||
                                                passwordController.text.isEmpty) {
                                              showDialog(
                                                context: context,
                                                builder: (BuildContext context) {
                                                  return EmptyFieldsDialog();
                                                },
                                              );
                                              return;
                                            }
                                            ///registro
                                          },
                                          child:
                                          _isLoading
                                              ? SizedBox(
                                            height: 20,
                                            width: 20,
                                            child:
                                            CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 4,
                                            ),
                                          )
                                              : Text(
                                            'Registrarse',
                                            style: AppText.smallTextStyle(
                                              Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          child: Text(
                            '¡Regístrate!',
                            style: AppText.subtitleStyle(
                              AppColors.primaryColorLight,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Guarda sin límites tus partidos',
                          style: AppText.subtitleStyle(Colors.grey),
                        ),
                        Text(
                          '¡No te lo pierdas!',
                          style: AppText.subtitleStyle(Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              )
              : matches.isEmpty
              ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      'No hay partidos registrados',
                      style: AppText.subtitleStyle(Colors.grey),
                    ),
                  ),
                ],
              )
              : Padding(
                // Lista de partidos cuando hay registros
                padding: const EdgeInsets.only(top: 8.0),
                child: ListView.builder(
                  itemCount: matches.length, // Número de partidos
                  itemBuilder: (ctx, index) {
                    final match = matches[index]; // Partido actual
                    return Card(
                      elevation: 10, // Sombra
                      color: AppColors.primaryColorLight, // Color de fondo
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Nombres de los equipos
                            Text(
                              '${match.team1.teamName} vs ${match.team2.teamName}',
                              style: AppText.smallTextStyle(Colors.white),
                            ),
                            // Ganador del partido
                            Text(
                              'Ganador: ${match.winner}',
                              style: AppText.smallTextStyle(Colors.white),
                            ),
                          ],
                        ),
                        // Resultado y fecha del partido
                        subtitle: Text(
                          '${match.team1TotalGames} - ${match.team2TotalGames} • ${match.date.toString().substring(0, 16)}',
                          style: AppText.verySmallTextStyle(Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
    );
  }
}