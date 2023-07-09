import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../states/password_state.dart';

class PasswordCheckBoxes extends StatelessWidget {
  const PasswordCheckBoxes({super.key, required this.passwordState});

  final PasswordState passwordState;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _checkBoxItem(AppLocalizations.of(context).password_length_hint,
            passwordState.highlightErrors, passwordState.correctLength),
        _checkBoxItem(AppLocalizations.of(context).password_uppercase_hint,
            passwordState.highlightErrors, passwordState.containsUppercase),
        _checkBoxItem(AppLocalizations.of(context).password_lowercase_hint,
            passwordState.highlightErrors, passwordState.containsLowercase),
        _checkBoxItem(AppLocalizations.of(context).password_number_hint,
            passwordState.highlightErrors, passwordState.containsNumbers),
      ],
    );
  }

  Widget _checkBoxItem(String text, bool shouldHighlight, bool isChecked) {
    Color color =
        shouldHighlight && !isChecked ? Colors.red : const Color(0xFF000000);

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
