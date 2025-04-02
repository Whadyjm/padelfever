import 'package:flutter/material.dart';

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
          controller: nombre,
          cursorColor: Colors.blue,
          decoration: InputDecoration(
            hintText: hintText,
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
