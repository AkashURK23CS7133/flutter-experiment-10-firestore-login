import 'package:flutter/material.dart';

/// Shown instead of the app when Firebase could not be initialised,
/// so the problem is visible rather than a blank or crashing app.
class FirebaseSetupScreen extends StatelessWidget {
  const FirebaseSetupScreen({super.key, required this.title, required this.error});

  final String title;
  final Object error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cloud_off, size: 56, color: Colors.orange),
                    const SizedBox(height: 12),
                    const Text('Firebase setup required',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    const Text(
                      'This app could not connect to Firebase.\n'
                      'In this project folder run:\n\n'
                      'dart pub global activate flutterfire_cli\n'
                      'flutterfire configure\n\n'
                      'then restart the app. See README.md for full steps.',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    SelectableText('Details: $error',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red, fontSize: 12)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
