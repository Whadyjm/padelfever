import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../../theme/text.dart';

class ErrorMessageDialog extends StatelessWidget {
  const ErrorMessageDialog({
    super.key,
    required this.errorMessage,
  });

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
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
  }
}