import 'package:flutter/material.dart';

class CommonValTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String label;
  final String hintText;
  final String? Function(String?) validator;
  final bool obscureText;
  final Widget? suffixIcon;
  final int maxlines;

  CommonValTextFormField({
    required this.controller,
    required this.keyboardType,
    required this.label,
    required this.hintText,
    required this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.maxlines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxlines,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        label: Text(label),
        hintText: hintText,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black38),
        ),
      ),
      validator: validator,
    );
  }
}
