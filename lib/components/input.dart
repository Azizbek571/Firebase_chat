import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({super.key,
  required this.controller,
  required this.hintText,
  required this.obscureText
  });
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200)
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200)
        ),
        fillColor: Colors.grey.shade200,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade500),
        filled: true
      ),
    );
  }
}