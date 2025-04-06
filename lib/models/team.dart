import 'dart:ui';

import 'package:padelpoint/models/player.dart';

class Team {
  final String id;
  final String name;
  final Player player1;
  final Player player2;
  final Color color;

  Team({
    required this.id,
    required this.name,
    required this.player1,
    required this.player2,
    required this.color,
  });

  String get teamName => name.isEmpty ? '${player1.name} - ${player2.name}' : name;
}