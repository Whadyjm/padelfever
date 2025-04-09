import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:padelpoint/screens/tabs/random_teams_screen.dart';
import 'package:padelpoint/theme/colors.dart';
import 'package:provider/provider.dart';
import '../providers/btn_provider.dart';
import '../theme/text.dart';
import '../widgets/authWidgets/authWidget.dart';
import 'tabs/create_teams_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 2,
      child: Stack(
        children:[
          Scaffold(
            backgroundColor: AppColors.scaffoldColorLight,
            appBar: AppBar(
              actions: [
                IconButton(
                  onPressed:
                      () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryScreen(),
                    ),
                  ),
                  icon: Icon(Icons.history, color: Colors.white, size: 30),
                ),
              ],
              backgroundColor: AppColors.appBarColorLight,
              title: Text(
                'PadelFever',
                style: AppText.titleStyle(Colors.white),
              ),
              bottom: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(40),
                    topLeft: Radius.circular(40),
                  ),
                ),
                tabs: [
                  Tab(
                    child: Text(
                      'Crear equipos',
                      style: AppText.smallTextStyle(Colors.white),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Modo aleatorio',
                      style: AppText.smallTextStyle(Colors.white),
                    ),
                  ),
                ],
              ),
            ),
            body: const TabBarView(
              children: [CreateTeamsScreen(), RandomTeamsScreen()],
            ),
          ),
          BlurBox()
        ]
      ),
    );
  }
}
