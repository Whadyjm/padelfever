import 'package:flutter/material.dart';
import 'package:padelpoint/theme/text.dart';

class AuthTextField extends StatelessWidget {
  AuthTextField({
    super.key,
    required this.nombre,
    required this.hintText,
    this.hidePassword,
  });

  final TextEditingController nombre;
  final String hintText;
  bool? hidePassword = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 280,
      child: TextFormField(
        obscureText: hidePassword ?? false,
        maxLength: 25,
        style: AppText.smallTextStyle(Colors.grey.shade700),
        controller: nombre,
        cursorColor: Colors.blue,
        decoration: InputDecoration(
          counterText: "",
          hintText: hintText,
          hintStyle: AppText.smallTextStyle(Colors.grey.shade500),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.5, color: Colors.grey.shade400),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
          ),
        ),
      ),
    );
  }
}
