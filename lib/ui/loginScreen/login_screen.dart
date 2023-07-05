import 'package:firebase_practice/ui/general/custom_form.dart';
import 'package:firebase_practice/ui/general/password_check_boxes.dart';
import 'package:firebase_practice/viewModels/log_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<LogInViewModel>(builder: (_, viewModel, child) {
      return Column(
        children: [
          const Text("Firebase App Test"),
          Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomForm(
                    viewModel.emailFormInput.value,
                    onChanged: (newValue) => viewModel.onEmailChanged(newValue),
                    validator: (email) => viewModel.validateEmail(email),
                  ),
                  CustomForm(
                    viewModel.passwordFormInput.value,
                    onChanged: (newValue) =>
                        viewModel.onPasswordChanged(newValue),
                  )
                ],
              )),
          PasswordCheckBoxes(passwordState: viewModel.passwordState),
          ElevatedButton(
              onPressed: () {
                _formKey.currentState?.validate();
                viewModel.highlightErrors();
              },
              child: const Text("Submit"))
        ],
      );
    });
  }
}