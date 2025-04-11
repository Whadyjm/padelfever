import 'package:flutter/material.dart';
import 'package:padelpoint/widgets/authWidgets/registerAlertDialog.dart';
import 'package:provider/provider.dart';

import '../../alertDialogs/authAlertDialogs/emptyFieldsDialog.dart';
import '../../providers/btn_provider.dart';
import '../../services/firebase_services.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import 'authTextField.dart';

class LoginAlertDialog {
  static showLoginAlertDialog(context, btnProvider) {
    bool _isLoading = false;
    TextEditingController userController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    bool _hide = true;

    return  showDialog(
      context: context,
      builder:
          (BuildContext context) => StatefulBuilder(
            builder:
                (context, setState) => AlertDialog(
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
                          suffixIcon: IconButton(
                            color: Colors.grey.shade500,
                            onPressed: () {
                              setState(() {
                                _hide = !_hide;
                              });
                            },
                            icon: Icon(
                              _hide
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                            ),
                          ),
                          hidePassword: _hide,
                          nombre: passwordController,
                          hintText: 'Contraseña',
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            '¿Olvidaste tu contraseña?',
                            style: AppText.smallTextStyle(Colors.grey.shade500),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            RegisterAlertDialog.showRegisterAlertDialog(
                              context,
                            );
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
                                      return EmptyFieldsDialog();
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
                                        child: CircularProgressIndicator(
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
          ),
    );
  }
}
