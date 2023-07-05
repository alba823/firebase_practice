import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_practice/data/services/firebase_service.dart';
import 'package:firebase_practice/firebase_options.dart';
import 'package:firebase_practice/locator.dart';
import 'package:firebase_practice/viewModels/log_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/loginScreen/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupLocator();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SafeArea(
              child: ChangeNotifierProvider(
                  create: (_) => LogInViewModel(
                      firebaseService: locator<FirebaseService>()),
                  child: LoginScreen())),
        ),
      ),
    );
  }
}