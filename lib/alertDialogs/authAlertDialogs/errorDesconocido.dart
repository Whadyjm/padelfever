import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/text.dart';

class ErrorDesconocido extends StatelessWidget {
  const ErrorDesconocido({
    super.key,
    required this.e,
  });

  final Object e;

  @override
  Widget build(BuildContext context) {
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
  }
}