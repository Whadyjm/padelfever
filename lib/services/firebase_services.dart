import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../alertDialogs/authAlertDialogs/errorDesconocido.dart';
import '../alertDialogs/authAlertDialogs/errorMessageDialog.dart';
import '../providers/btn_provider.dart';
import '../theme/colors.dart';
import '../theme/text.dart';

class FirebaseServices {

  // Método para autenticar al usuario con Firebase
  Future Auth(context, userController, passwordController) async {
    final btnProvider = Provider.of<BtnProvider>(context, listen: false);

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userController.text.trim(),
        password: passwordController.text.trim(),
      );
      Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Inicio de sesión exitoso',
                style: AppText.smallTextStyle(Colors.white),
              ),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
      userController.clear();
      passwordController.clear();

      btnProvider.success = true;

    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'El correo electrónico y/o contraseña no es válido.';
          break;
        case 'user-not-found':
          errorMessage = 'No se encontró un usuario con este correo.';
          break;
        case 'wrong-password':
          errorMessage = 'La contraseña es incorrecta.';
          break;
        case 'network-request-failed':
          errorMessage = 'Error de red. Verifica tu conexión.';
          break;
        default:
          errorMessage = 'El correo electrónico y/o contraseña no es válido.';
      }
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorMessageDialog(errorMessage: errorMessage);
        },
      );
      return;
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return ErrorDesconocido(e: e);
        },
      );
    } finally {
      userController.clear();
      passwordController.clear();
    }
  }
}