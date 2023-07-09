import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_practice/ui/general/custom_button.dart';
import 'package:firebase_practice/viewModels/home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              Text(AppLocalizations.of(context).user_info(user.prettyString)),
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
                text: AppLocalizations.of(context).sign_out_cta,
              ),
              const SizedBox(height: 24),
              CustomButton(
                isLoading: viewModel.isVerifyEmailLoading,
                onPressed: () {
                  viewModel.sendEmailVerification(
                    onSuccess: () {
                      final snackBar = SnackBar(
                        content: Text(AppLocalizations.of(context).email_verification_sent_snack_bar),
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
                text: AppLocalizations.of(context).verify_email_cta,
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
