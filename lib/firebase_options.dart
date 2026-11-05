// =====================================================================
// PLACEHOLDER – NOT A REAL FIREBASE CONFIGURATION.
//
// This file contains no Firebase keys. It exists only so the project
// compiles before you connect your own Firebase project.
//
// To connect Firebase, run in this project folder:
//     dart pub global activate flutterfire_cli
//     flutterfire configure
// FlutterFire CLI will OVERWRITE this file with your real settings.
// =====================================================================
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform => throw UnsupportedError(
        'Firebase is not configured yet. Run "flutterfire configure" in this '
        'project folder to generate lib/firebase_options.dart.',
      );
}
