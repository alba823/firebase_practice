import 'package:firebase_practice/ui/general/custom_button.dart';
import 'package:firebase_practice/ui/general/email_and_password_form.dart';
import 'package:firebase_practice/ui/screens/sign_up_screen.dart';
import 'package:firebase_practice/viewModels/log_in_view_model.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  static String get route => "/login";

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<LogInViewModel>(
      builder: (_, viewModel, child) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.all(24),
              child: Text("Log in"),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EmailAndPasswordForm(
                    _formKey,
                    emailController: viewModel.emailController,
                    passwordController: viewModel.passwordController,
                    highlightErrors: viewModel.passwordState.highlightErrors,
                    emailValidator: (email) => viewModel.validateEmail(email),
                    onPasswordChanged: (newValue) =>
                        viewModel.onPasswordChanged(newValue),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Don't have an account?\n",
                            style: DefaultTextStyle.of(context).style,
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: 'Sign up',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                final email = await Navigator.pushNamed(
                                  context,
                                  SignUpScreen.route,
                                ) as String;
                                viewModel.onEmailChanged(email);
                              },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: CustomButton(
                onPressed: () => _onLogInPressed(context, viewModel),
                text: "Log in",
                isLoading: viewModel.isButtonLoading,
              ),
            ),
          ],
        );
      },
    );
  }

  void _onLogInPressed(BuildContext context, LogInViewModel viewModel) {
    final isEmailValid = _formKey.currentState?.validate() ?? false;
    viewModel.logInWithEmailAndPassword(
      isEmailValid,
      onSuccess: (user) async {
        Navigator.pushNamed(context, HomeScreen.route, arguments: user);
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
