import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_practice/data/services/firebase_service.dart';
import 'package:firebase_practice/firebase_options.dart';
import 'package:firebase_practice/locator.dart';
import 'package:firebase_practice/ui/general/scaffold_wrapper.dart';
import 'package:firebase_practice/ui/screens/sign_up_screen.dart';
import 'package:firebase_practice/viewModels/home_view_model.dart';
import 'package:firebase_practice/viewModels/log_in_view_model.dart';
import 'package:firebase_practice/viewModels/sign_up_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/screens/home_screen.dart';
import 'ui/screens/login_screen.dart';

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
      theme: ThemeData.light(),
      initialRoute: LoginScreen.route,
      routes: {
        LoginScreen.route: (context) => ChangeNotifierProvider(
              create: (_) =>
                  LogInViewModel(firebaseService: locator<FirebaseService>()),
              child: ScaffoldWrapper(
                child: LoginScreen(),
              ),
            ),
        SignUpScreen.route: (context) => ChangeNotifierProvider(
              create: (_) =>
                  SignUpViewModel(firebaseService: locator<FirebaseService>()),
              child: ScaffoldWrapper(child: SignUpScreen()),
            ),
        HomeScreen.route: (context) => ChangeNotifierProvider(
              create: (_) => HomeViewModel(
                firebaseService: locator<FirebaseService>(),
              ),
              child: const ScaffoldWrapper(child: HomeScreen()),
            ),
      },
    );
  }
}