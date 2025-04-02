import 'package:flutter/material.dart';
import 'package:padelpoint/providers/btn_provider.dart';
import 'package:padelpoint/providers/match_provider.dart';
import 'package:padelpoint/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => MatchProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => BtnProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
        routes: {
          HomeScreen.routeName: (ctx) => const HomeScreen(),
        },
      ),
    );
  }
}