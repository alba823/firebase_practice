import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  const CustomForm(this._value,
      {super.key, required this.onChanged, this.validator});

  final String? _value;
  final Function(String?) onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        initialValue: _value, onChanged: onChanged, validator: validator);
  }
}