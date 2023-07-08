import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  const CustomForm(
      {super.key,
      this.onChanged,
      this.validator,
      this.underlineColor,
      required this.hintText,
      bool? obscureText,
      required this.controller})
      : obscureText = obscureText ?? false;

  final Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final Color? underlineColor;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(8),
        hintText: hintText,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
