import 'package:flutter/material.dart';

import '../theme/text.dart';

class TeamNameTextField extends StatelessWidget {
  TeamNameTextField({super.key, required this.controller, required this.hintText});

  TextEditingController controller = TextEditingController();
  String hintText;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width - 100,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText:
          hintText,
        ),
        style: AppText.subtitleStyle(Colors.grey.shade700),
      ),
    );
  }
}
