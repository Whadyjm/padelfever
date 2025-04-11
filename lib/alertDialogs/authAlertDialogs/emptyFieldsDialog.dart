import 'package:flutter/material.dart';

import '../../theme/colors.dart';
import '../../theme/text.dart';

class EmptyFieldsDialog extends StatelessWidget {
  const EmptyFieldsDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
  }
}