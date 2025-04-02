import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/match_provider.dart';

class HistoryScreen extends StatelessWidget {
  static const routeName = '/history';
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final matches = Provider.of<MatchProvider>(context).matches;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de partidos'),
      ),
      body: matches.isEmpty
          ? const Center(
        child: Text('No hay partidos registrados'),
      )
          : ListView.builder(
        itemCount: matches.length,
        itemBuilder: (ctx, index) {
          final match = matches[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(
                '${match.team1.teamName} vs ${match.team2.teamName}',
              ),
              subtitle: Text(
                '${match.team1TotalGames} - ${match.team2TotalGames} • ${match.date.toString().substring(0, 16)}',
              ),
              trailing: Text(
                'Ganador: ${match.winner}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}