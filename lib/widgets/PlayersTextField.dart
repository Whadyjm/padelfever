import 'package:flutter/material.dart';
import 'package:padelpoint/theme/text.dart';

class PlayersTextField extends StatelessWidget {
  const PlayersTextField({super.key, required this.nombre, required this.hintText});

  final TextEditingController nombre;
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: 200,
        child: TextFormField(
          style: AppText.smallTextStyle(Colors.grey.shade700),
          controller: nombre,
          cursorColor: Colors.blue,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppText.smallTextStyle(Colors.grey.shade500),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        )
    );
  }
}
