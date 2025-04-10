import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/btn_provider.dart';
import '../theme/text.dart';

class FirebaseServices {

  Future Auth(context, userController, passwordController) async {

    final btnProvider = Provider.of<BtnProvider>(context, listen: false);

    try {
      await FirebaseAuth.instance
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
        userController.clear();
        passwordController.clear();
        btnProvider.hideBlur();
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'user-not-found') {
        errorMessage = 'No se encontró un usuario con ese correo.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Contraseña incorrecta.';
      } else {
        errorMessage = 'Error de autenticación.';
      }
    }
  }
}