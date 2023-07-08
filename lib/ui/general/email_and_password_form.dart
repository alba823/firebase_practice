import 'package:firebase_practice/ui/general/custom_form.dart';
import 'package:flutter/material.dart';

class EmailAndPasswordForm extends StatelessWidget {
  const EmailAndPasswordForm(
      this._formKey, {
        super.key,
        required this.highlightErrors,
        required this.emailValidator,
        required this.onPasswordChanged,
        required this.emailController,
        required this.passwordController,
      });

  final GlobalKey<FormState> _formKey;
  final bool highlightErrors;
  final TextEditingController emailController;
  final Function(String?) emailValidator;
  final TextEditingController passwordController;
  final Function(String?) onPasswordChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomForm(
            controller: emailController,
            hintText: "Email",
            validator: (email) => emailValidator(email),
          ),
          const SizedBox(height: 24),
          CustomForm(
            controller: passwordController,
            hintText: "Password",
            obscureText: true,
            underlineColor: highlightErrors ? Colors.red : null,
            onChanged: (newValue) => onPasswordChanged(newValue),
            validator: (password) =>
            password?.isEmpty == true ? "This field is required" : null,
          ),
        ],
      ),
    );
  }
}