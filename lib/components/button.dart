import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.onTap, required this.text});
  final void Function()? onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsetsDirectional.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadiusDirectional.circular(5),
          ),
          child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600,fontSize: 16),)
        ));
  }
}
