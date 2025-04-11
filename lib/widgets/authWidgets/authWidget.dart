import 'package:blur/blur.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:padelpoint/providers/btn_provider.dart';
import 'package:padelpoint/widgets/authWidgets/authTextField.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/firebase_services.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';

class BlurBox extends StatefulWidget {
  const BlurBox({super.key});

  @override
  State<BlurBox> createState() => _BlurBoxState();
}

class _BlurBoxState extends State<BlurBox> {
  bool _isLoading = false;
  TextEditingController userController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final btnProvider = Provider.of<BtnProvider>(context, listen: true);

    final blur = btnProvider.blur;
    return Visibility(
      visible: blur ? true : false,
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height,
        width: MediaQuery.sizeOf(context).width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                hoverColor: Colors.transparent,
                splashColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                height: 50,
                minWidth: 200,
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'PadelFever',
                      style: TextStyle(
                        fontFamily: 'sf-pro-display',
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Icon(
                      Icons.sports_tennis_rounded,
                      color: AppColors.secondaryColorLight,
                      size: 50,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                height: 50,
                minWidth: 200,
                color: AppColors.primaryColorLight,
                onPressed: () async {
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
                                  onPressed: () {},
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
                                        if (userController.text.isEmpty ||
                                            passwordController.text.isEmpty) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                        Radius.circular(12),
                                                      ),
                                                ),
                                                backgroundColor: Colors.white,
                                                title: Text(
                                                  'Oops!',
                                                  style: AppText.titleStyle(
                                                    Colors.redAccent,
                                                  ),
                                                ),
                                                content: Text(
                                                  'Por favor, completa todos los campos.',
                                                  style: AppText.smallTextStyle(
                                                    Colors.black,
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(
                                                        context,
                                                      ).pop(); // Close the dialog
                                                    },
                                                    child: Text(
                                                      'Reintentar',
                                                      style: AppText.smallTextStyle(
                                                        AppColors
                                                            .primaryColorLight,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                          return;
                                        }
                                        setState(() {
                                          _isLoading = true;
                                        });
                                        await FirebaseServices().Auth(
                                          context,
                                          userController,
                                          passwordController,
                                        );
                                        btnProvider.success
                                            ? setState(() {
                                              _isLoading = false;
                                              btnProvider.hideBlur();
                                            })
                                            : setState(() {
                                              _isLoading = false;
                                            });
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
                                                'Iniciar sesión',
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
                  'Iniciar sesión',
                  style: AppText.smallTextStyle(Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                height: 50,
                minWidth: 200,
                color: AppColors.primaryColorLight,
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                  });
                  try {
                    await Future.delayed(Duration(seconds: 2));
                  } finally {
                    setState(() {
                      _isLoading = false;
                      btnProvider.hideBlur();
                      btnProvider.setGuest();
                    });
                  }
                },
                child:
                    _isLoading
                        ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 4,
                          ),
                        )
                        : Text(
                          'Invitado',
                          style: AppText.smallTextStyle(Colors.white),
                        ),
              ),
            ),
          ],
        ),
      ).frosted(blur: 5, frostColor: Colors.black),
    );
  }
}
