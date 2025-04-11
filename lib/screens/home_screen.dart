import 'package:blur/blur.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:padelpoint/screens/tabs/random_teams_screen.dart';
import 'package:padelpoint/theme/colors.dart';
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
  bool _isLoading = false;
  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final btnProvider = Provider.of<BtnProvider>(context, listen: true);
    final currentUser = FirebaseAuth.instance.currentUser;

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
                    : IconButton(
                      onPressed:
                          () => showDialog(
                            context: context,
                            builder:
                                (BuildContext context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                  ),
                                  backgroundColor: Colors.white,
                                  content: SizedBox(
                                    height: 300,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                              onPressed:
                                                  () => Navigator.pop(context),
                                              icon: Icon(
                                                Icons.close_rounded,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Inicio de sesión',
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
                                          hidePassword: true,
                                          nombre: passwordController,
                                          hintText: 'Contraseña',
                                        ),
                                        const SizedBox(height: 10),
                                        TextButton(
                                          onPressed: () {},
                                          child: Text(
                                            '¿Olvidaste tu contraseña?',
                                            style: AppText.smallTextStyle(
                                              Colors.grey.shade500,
                                            ),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                              registerAlertDialog(context);
                                            },
                                          child: Text(
                                            'Regístrate',
                                            style: AppText.smallTextStyle(
                                              AppColors.primaryColorLight,
                                            ),
                                          ),
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
                                              void Function(void Function())
                                              setState,
                                            ) => MaterialButton(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(8),
                                                ),
                                              ),
                                              height: 50,
                                              minWidth: 200,
                                              color:
                                                  AppColors.primaryColorLight,
                                              onPressed: () async {
                                                if (userController
                                                        .text
                                                        .isEmpty ||
                                                    passwordController
                                                        .text
                                                        .isEmpty) {
                                                  showDialog(
                                                    context: context,
                                                    builder: (
                                                      BuildContext context,
                                                    ) {
                                                      return EmptyFieldsDialog();
                                                    },
                                                  );
                                                  return;
                                                }
                                                await authProcess(
                                                  setState,
                                                  context,
                                                  btnProvider,
                                                );
                                              },
                                              child:
                                                  _isLoading
                                                      ? SizedBox(
                                                        height: 20,
                                                        width: 20,
                                                        child:
                                                            CircularProgressIndicator(
                                                              color:
                                                                  Colors.white,
                                                              strokeWidth: 4,
                                                            ),
                                                      )
                                                      : Text(
                                                        'Iniciar sesión',
                                                        style:
                                                            AppText.smallTextStyle(
                                                              Colors.white,
                                                            ),
                                                      ),
                                            ),
                                      ),
                                    ),
                                  ],
                                ),
                          ),
                      icon: Icon(Icons.person, color: Colors.white, size: 30),
                    ),
                const SizedBox(width: 10),
                currentUser != null
                    ? IconButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.logout_rounded,
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

  void registerAlertDialog(BuildContext context) {
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
  }

  Future<void> authProcess(
    setState,
    BuildContext context,
    BtnProvider btnProvider,
  ) async {
    setState(() {
      _isLoading = true;
    });
    await FirebaseServices().Auth(context, userController, passwordController);
    btnProvider.success
        ? setState(() {
          _isLoading = false;
          btnProvider.hideBlur();
        })
        : setState(() {
          _isLoading = false;
        });
  }
}
