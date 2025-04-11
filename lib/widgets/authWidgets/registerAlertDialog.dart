import 'package:flutter/material.dart';

import '../../alertDialogs/authAlertDialogs/emptyFieldsDialog.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import 'authTextField.dart';

class RegisterAlertDialog {
  static Future<void> showRegisterAlertDialog(context) async {
    bool _isLoading = false;
    bool _hide = true;
    TextEditingController userController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    await showDialog(
      barrierDismissible: false,
      context: context,
      builder:
          (context) => StatefulBuilder(
            builder:
                (
                  BuildContext context,
                  void Function(void Function()) setState,
                ) => AlertDialog(
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
                                    emailController.text.isEmpty ||
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
                                        child: CircularProgressIndicator(
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
          ),
    );
  }
}
