import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/btn_provider.dart';
import '../theme/text.dart';

class FirebaseServices {

  Future Auth(context, userController, passwordController, _isLoading) async {

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
        //btnProvider.hideBlur();
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'El correo electrónico no es válido.';
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
          errorMessage = 'Ocurrió un error inesperado. Inténtalo de nuevo.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.red,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error desconocido: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      userController.clear();
      passwordController.clear();
    }
  }
}