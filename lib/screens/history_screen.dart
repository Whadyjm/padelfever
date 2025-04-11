import 'package:flutter/material.dart';
import 'package:padelpoint/providers/colors_provider.dart';
import 'package:provider/provider.dart';
import '../providers/btn_provider.dart';
import '../providers/match_provider.dart';
import '../theme/colors.dart';
import '../theme/text.dart';

/// Pantalla que muestra el historial de partidos jugados
class HistoryScreen extends StatelessWidget {
  static const routeName = '/history'; // Ruta de navegación
  const HistoryScreen({super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
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
                          onPressed: () {},
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
