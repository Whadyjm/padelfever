import 'package:flutter/material.dart';

import '../theme/text.dart';

class CustomButtom extends StatelessWidget {
  CustomButtom({super.key, required this.color, required this.text});

  final Color color;
  final String text;
  void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      height: 50,
      minWidth: 200,
      color: color,
      onPressed: onPressed,
      child: Text(text, style: AppText.smallTextStyle(Colors.white)),
    );
  }
}
