import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/text.dart';

class AppBtn extends StatelessWidget {
  const AppBtn({super.key, this.onPressed, required this.text});

  final void Function()? onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      height: 50,
      minWidth: 200,
      color: AppColors.primaryColorLight,
      onPressed: onPressed,
      child: Text(text, style: AppText.smallTextStyle(Colors.white)),
    );
  }
}
