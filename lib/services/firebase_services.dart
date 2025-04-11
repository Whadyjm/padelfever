import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/btn_provider.dart';
import '../theme/colors.dart';
import '../theme/text.dart';

class FirebaseServices {
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
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            backgroundColor: Colors.white,
            title: Text(
              'Oops!',
              style: AppText.titleStyle(Colors.redAccent),
            ),
            content: Text(
              errorMessage,
              style: AppText.smallTextStyle(Colors.black),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(
                  'Reintentar',
                  style: AppText.smallTextStyle(AppColors.primaryColorLight),
                ),
              ),
            ],
          );
        },
      );
      return;
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Error desconocido',
              style: AppText.titleStyle(Colors.red),
            ),
            content: Text(
              'Error desconocido: $e',
              style: AppText.smallTextStyle(Colors.black),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(
                  'Aceptar',
                  style: AppText.smallTextStyle(Colors.red),
                ),
              ),
            ],
          );
        },
      );
    } finally {
      userController.clear();
      passwordController.clear();
    }
  }
}