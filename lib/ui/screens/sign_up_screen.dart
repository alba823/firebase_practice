import 'package:firebase_practice/ui/general/custom_button.dart';
import 'package:firebase_practice/ui/general/email_and_password_form.dart';
import 'package:firebase_practice/ui/general/password_check_boxes.dart';
import 'package:firebase_practice/viewModels/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  static String get route => "/signup";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpViewModel>(
      builder: (_, viewModel, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(AppLocalizations.of(context).sign_up_cta),
            ),
            Expanded(
              child: Column(
                children: [
                  EmailAndPasswordForm(
                    _formKey,
                    emailController: viewModel.emailController,
                    passwordController: viewModel.passwordController,
                    highlightErrors: viewModel.passwordState.highlightErrors,
                    emailValidator: (email) => viewModel.validateEmail(
                      email: email,
                      requiredFieldMessage:
                          AppLocalizations.of(context).required_field,
                      invalidEmailMessage:
                          AppLocalizations.of(context).email_is_not_valid,
                    ),
                    onPasswordChanged: (newValue) =>
                        viewModel.onPasswordChanged(newValue),
                  ),
                  PasswordCheckBoxes(passwordState: viewModel.passwordState),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: CustomButton(
                onPressed: () => _onSignUpPressed(context, viewModel),
                text: AppLocalizations.of(context).sign_up_cta,
              ),
            ),
          ],
        );
      },
    );
  }

  void _onSignUpPressed(BuildContext context, SignUpViewModel viewModel) {
    final isEmailValid = _formKey.currentState?.validate() ?? false;
    viewModel.signUpWithEmailAndPassword(
      isEmailValid,
      onSuccess: (user) {
        Navigator.pop<String>(context, viewModel.emailController.text);
      },
      onFailure: (e) {
        final snackBar = SnackBar(
          content: Text("$e"),
          backgroundColor: Colors.red,
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }
}
