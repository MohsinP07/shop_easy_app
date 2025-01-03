import 'package:flutter/material.dart';

class CommonValTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String label;
  final String hintText;
  final String? Function(String?)? validator;
  final void Function(String)? onChange;
  final VoidCallback? onClick;
  final bool obscureText;
  final bool? isVisible;
  final Widget? suffixIcon;
  final int maxlines;

  CommonValTextFormField({
    required this.controller,
    required this.keyboardType,
    required this.label,
    required this.hintText,
    required this.validator,
    this.onClick,
    this.isVisible,
    this.onChange,
    this.obscureText = false,
    this.suffixIcon,
    this.maxlines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxlines,
          obscureText: obscureText,
          onChanged: onChange,
          enabled: isVisible,
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
        ),
      ),
    );
  }
}
