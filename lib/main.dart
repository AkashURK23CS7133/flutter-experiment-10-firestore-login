// Experiment 10: Manual User Login Authentication using Google Firestore
//
// ⚠️ EDUCATIONAL DEMO ONLY – NOT SECURE.
// Passwords are stored in plain text in Firestore and checked on the
// client. Anyone with read access to the "users" collection can see every
// password. Real apps must use Firebase Authentication (or another auth
// server) and never store plaintext passwords. This design is used here
// only because the lab exercise explicitly requires it.
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'firebase_options.dart';
import 'firebase_setup_screen.dart';
import 'login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Object? initError;
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    initError = e;
  }
  runApp(MyApp(initError: initError));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.initError});

  final Object? initError;

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'User Login',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
        ),
        home: initError == null
            ? const LoginPage()
            : FirebaseSetupScreen(title: 'User Login', error: initError!),
      );
}
