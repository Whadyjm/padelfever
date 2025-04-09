import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:padelpoint/providers/btn_provider.dart';
import 'package:padelpoint/widgets/authWidgets/authTextField.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';

class BlurBox extends StatefulWidget {
  const BlurBox({super.key});

  @override
  State<BlurBox> createState() => _BlurBoxState();
}

class _BlurBoxState extends State<BlurBox> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {

    TextEditingController userController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final btnProvider = Provider.of<BtnProvider>(context, listen: false);

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
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                      backgroundColor: Colors.white,
                      content: SizedBox(
                        height: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Inicio de sesión',
                              style: AppText.titleStyle(AppColors.primaryColorLight),
                            ),
                            const SizedBox(height: 10),
                            AuthTextField(
                              nombre: userController,
                              hintText: 'Usuario',
                            ),
                            const SizedBox(height: 10),
                            AuthTextField(
                              nombre: passwordController,
                              hintText: 'Contraseña',
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    '¿Olvidaste tu contraseña?',
                                    style: AppText.smallTextStyle(Colors.grey.shade500),
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
                          ],
                        ),
                      ),
                      actions: [
                        Center(
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            height: 50,
                            minWidth: 200,
                            color: AppColors.primaryColorLight,
                            onPressed: () async {
                              try {
                                final credential = await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: userController.text.trim(),
                                  password: passwordController.text.trim(),
                                );
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Inicio de sesión exitoso', style: AppText.smallTextStyle(Colors.white),),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                              } on FirebaseAuthException catch (e) {
                                String errorMessage;
                                if (e.code == 'user-not-found') {
                                  errorMessage = 'No se encontró un usuario con ese correo.';
                                } else if (e.code == 'wrong-password') {
                                  errorMessage = 'Contraseña incorrecta.';
                                } else {
                                  errorMessage = 'Error de autenticación.';
                                }
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(errorMessage, style: AppText.smallTextStyle(Colors.white),),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              } finally {
                                setState(() {
                                  userController.clear();
                                  passwordController.clear();
                                  btnProvider.hideBlur();
                                });
                              }
                            },
                            child: Text(
                              'Iniciar sesión',
                              style: AppText.smallTextStyle(Colors.white),
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
                    _isLoading = true; // Show loading indicator
                  });
                  try {
                    await Future.delayed(Duration(seconds: 2));
                  } finally {
                    setState(() {
                      _isLoading = false;
                      btnProvider.hideBlur();
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