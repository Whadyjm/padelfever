import 'package:flutter/material.dart';
import 'package:padelpoint/providers/colors_provider.dart';
import 'package:provider/provider.dart';
import '../providers/match_provider.dart';
import '../theme/colors.dart';
import '../theme/text.dart';

class HistoryScreen extends StatelessWidget {
  static const routeName = '/history';
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final matches = Provider.of<MatchProvider>(context).matches;

    void _clearConfirmation() {
      showDialog(
        context: context,
        barrierDismissible: false,
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
                TextButton(
                  onPressed: () {
                    final provider = Provider.of<MatchProvider>(
                      context,
                      listen: false,
                    );
                    provider.clearMatches();
                    Navigator.of(ctx).pop();
                  },
                  child: Center(
                    child: Text(
                      'Continuar',
                      style: AppText.subtitleStyle(Colors.blue),
                    ),
                  ),
                ),
                const Divider(),
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
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
        backgroundColor: AppColors.primaryColorLight,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        ),
        title: Text(
          'Historial de partidos',
          style: AppText.titleStyle(Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () => matches.isEmpty ? null : _clearConfirmation(),
            icon: Icon(Icons.delete, color: Colors.white),
          ),
        ],
      ),
      body:
          matches.isEmpty
              ? Center(
                child: Text(
                  'No hay partidos registrados',
                  style: AppText.subtitleStyle(Colors.grey),
                ),
              )
              : Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ListView.builder(
                  itemCount: matches.length,
                  itemBuilder: (ctx, index) {
                    final match = matches[index];
                    return Card(
                      elevation: 10,
                      color: AppColors.primaryColorLight,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${match.team1.teamName} vs ${match.team2.teamName}',
                              style: AppText.smallTextStyle(Colors.white),
                            ),
                            Text(
                              'Ganador: ${match.winner}',
                              style: AppText.smallTextStyle(Colors.white),
                            ),
                          ],
                        ),
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
