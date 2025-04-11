import 'package:blur/blur.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:padelpoint/screens/tabs/random_teams_screen.dart';
import 'package:padelpoint/theme/colors.dart';
import 'package:padelpoint/widgets/authWidgets/loginAlertDialog.dart';
import 'package:provider/provider.dart';
import '../alertDialogs/authAlertDialogs/emptyFieldsDialog.dart';
import '../providers/btn_provider.dart';
import '../services/firebase_services.dart';
import '../theme/text.dart';
import '../widgets/authWidgets/authTextField.dart';
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
    final currentUser = FirebaseAuth.instance.currentUser;
    final btnProvider = Provider.of<BtnProvider>(context, listen: true);

    return DefaultTabController(
      length: 2,
      child: Stack(
        children: [
          Scaffold(
            backgroundColor: AppColors.scaffoldColorLight,
            appBar: AppBar(
              actions: [
                currentUser != null
                    ? Text(
                      '${currentUser.email?.substring(0, 14)}',
                      style: AppText.smallTextStyle(Colors.white),
                    )
                    : TextButton(
                      onPressed: () {
                        LoginAlertDialog.showLoginAlertDialog(context, btnProvider);
                      },
                      child: Text(
                        'Inicia sesión',
                        style: AppText.smallTextStyle(Colors.white),
                      ),
                    ),
                const SizedBox(width: 10),
                currentUser != null
                    ? IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.person_rounded,
                        size: 30,
                        color: Colors.white,
                      ),
                    )
                    : const SizedBox.shrink(),
                const SizedBox(width: 10),
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
          AuthWidget(),
        ],
      ),
    );
  }
}
