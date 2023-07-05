import 'package:firebase_practice/viewModels/log_in_view_model.dart';
import 'package:flutter/material.dart';

class PasswordCheckBoxes extends StatelessWidget {
  const PasswordCheckBoxes({super.key, required this.passwordState});

  final PasswordState passwordState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _checkBoxItem("At least 8 characters", passwordState.highlightErrors,
            passwordState.correctLength),
        _checkBoxItem("At least 1 uppercase", passwordState.highlightErrors,
            passwordState.containsUppercase),
        _checkBoxItem("At least 1 lowercase", passwordState.highlightErrors,
            passwordState.containsLowercase),
        _checkBoxItem("At least 1 number", passwordState.highlightErrors,
            passwordState.containsNumbers),
      ],
    );
  }

  Widget _checkBoxItem(String text, bool shouldHighlight, bool isChecked) {
    Color color = shouldHighlight && !isChecked ? Colors.red : const Color(0xFF000000);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text, style: TextStyle(color: color)),
        Checkbox(
          value: isChecked,
          onChanged: (_) {},
          shape: const CircleBorder(),
          side: BorderSide(
            color: color,
          ),
        ),
      ],
    );
  }
}