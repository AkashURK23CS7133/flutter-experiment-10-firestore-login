# Experiment 10 – Manual User Login Authentication using Google Firestore Database

## Aim

To develop a Flutter application that allows user login using email and password stored in Google Firestore Database, without using Firebase Authentication.

## Features

- Login screen with Email, Password (show/hide) and **Login** button
- Looks up the user in the **`users`** collection by email and compares the password
- Valid → **User Dashboard**: *Welcome, &lt;name&gt;*, email and phone
- Invalid → *Invalid email or password*
- **Logout** clears navigation and returns to the login screen

## Source files

`lib/main.dart`, `lib/login_page.dart`, `lib/dashboard_page.dart`, `lib/firebase_options.dart`, `lib/firebase_setup_screen.dart`

## Dependencies

`firebase_core`, `cloud_firestore`; dev only: `fake_cloud_firestore`

## Connecting your Firebase project (one-time, manual)

This project ships with a **placeholder** `lib/firebase_options.dart` that contains **no keys**. Until you replace it, the app starts and shows a **"Firebase setup required"** screen. That is expected; it is not a crash.

1. Go to <https://console.firebase.google.com> → **Add project** (any name, e.g. `flutter-lab-urk23cs7133`). Google Analytics is optional.
2. In the project: **Build → Firestore Database → Create database** → pick a location → start in **test mode** (fine for a lab; see *Security* below).
3. Install the Firebase CLI and log in (needs Node.js, which you already have):
   ```powershell
   npm install -g firebase-tools
   firebase login
   ```
4. Install the FlutterFire CLI:
   ```powershell
   dart pub global activate flutterfire_cli
   ```
   If `flutterfire` is "not recognized", add `%LOCALAPPDATA%\Pub\Cache\bin` to your PATH and reopen the terminal.
5. **In this project folder**, run:
   ```powershell
   flutterfire configure --platforms=web,android
   ```
   Pick your Firebase project. This **overwrites** `lib/firebase_options.dart` with your real settings (and creates `android/app/google-services.json` for Android).
6. Create the collection and sample documents shown below (Firestore console → **Start collection**).
7. `flutter run -d chrome`. The real screen now appears instead of the setup screen.

You can reuse the same Firebase project for Experiments 7–10, but you must run `flutterfire configure` **in each project folder** separately.

**Security:** test-mode rules let anyone read/write your database for 30 days. That's OK for a lab demo; delete the project or lock the rules afterwards.

## Firestore data

Create collection **`users`** manually. Example document:

| Field | Type | Example |
|---|---|---|
| `name` | string | `Akash K` |
| `email` | string | `akash@example.com` |
| `phone` | string | `9876543210` |
| `password` | string | `lab123` |

> ⚠️ **Security warning: lab demonstration only.** Storing passwords in plain text and checking them in the app is **insecure**: anyone who can read the `users` collection can read every password, and the check can be bypassed. Never do this in a real app; use **Firebase Authentication** (which hashes passwords server-side) instead. This experiment deliberately follows the lab specification. Use a throw-away password, not a real one.

## Run

Open a terminal **in this folder**, then:

```powershell
flutter pub get        # download packages
flutter analyze        # should print "No issues found!"
flutter test           # automated tests
flutter run -d chrome  # start the app in Chrome
```

## Expected output

Correct credentials → dashboard with *Welcome, Akash K*; wrong password → *Invalid email or password*; Logout → back to login.

Screenshots of the running app: [`../OUTPUTS/Experiment_10/`](../OUTPUTS/Experiment_10/)

## Troubleshooting

- **"Firebase setup required" screen**: `lib/firebase_options.dart` is still the placeholder. Do the *Connecting your Firebase project* steps.
- **`permission-denied`**: your Firestore rules block access. Use test mode or allow read/write on the collection for the lab.
- **`flutterfire` not recognized**: add `%LOCALAPPDATA%\Pub\Cache\bin` to PATH.
- **"Unable to determine engine version"**: put real Git first on PATH (see master README).
