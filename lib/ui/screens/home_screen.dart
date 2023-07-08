import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/ui/general/custom_button.dart';
import 'package:firebase_practice/viewModels/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static String get route => '/home';

  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as User;

    return Consumer<HomeViewModel>(
      builder: (_, viewModel, __) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("User: ${user.prettyString}"),
              const SizedBox(height: 48),
              CustomButton(
                isLoading: viewModel.isSignOutLoading,
                onPressed: () {
                  viewModel.signOut(
                    onSuccess: () {
                      Navigator.pop(context);
                    },
                    onFailure: (exception) {
                      final snackBar = SnackBar(
                        content: Text("$exception"),
                        backgroundColor: Colors.red,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  );
                },
                text: "Sign Out",
              ),
              const SizedBox(height: 24),
              CustomButton(
                isLoading: viewModel.isVerifyEmailLoading,
                onPressed: () {
                  viewModel.sendEmailVerification(
                    onSuccess: () {
                      const snackBar = SnackBar(
                        content: Text("Email verification has been sent"),
                        backgroundColor: Colors.green,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    onFailure: (exception) {
                      final snackBar = SnackBar(
                        content: Text("$exception"),
                        backgroundColor: Colors.red,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                  );
                },
                text: "Verify email",
              ),
            ],
          ),
        );
      },
    );
  }
}

extension on User {
  String get prettyString =>
      "Email: $email\nDisplayName: $displayName\nIsAnonymous: $isAnonymous\nID: $uid\nEmail: $email\nIsVerified: $emailVerified";
}
