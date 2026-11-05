import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:exp10_firestore_login/login_page.dart';
import 'package:exp10_firestore_login/main.dart';

void main() {
  testWidgets('Setup screen when Firebase is not configured', (tester) async {
    await tester.pumpWidget(MyApp(initError: UnsupportedError('x')));
    expect(find.text('Firebase setup required'), findsOneWidget);
  });

  testWidgets('Invalid login, valid login -> dashboard, logout', (tester) async {
    tester.view.physicalSize = const Size(800, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    final db = FakeFirebaseFirestore();
    await db.collection('users').add({
      'name': 'Akash K',
      'email': 'akash@example.com',
      'phone': '9876543210',
      'password': 'lab123',
    });
    await tester.pumpWidget(MaterialApp(home: LoginPage(firestore: db)));

    await tester.tap(find.text('Login'));
    await tester.pump();
    expect(find.text('Please enter email and password'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('emailField')), 'akash@example.com');
    await tester.enterText(find.byKey(const Key('passwordField')), 'wrong');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    expect(find.text('Invalid email or password'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('passwordField')), 'lab123');
    await tester.tap(find.text('Login'));
    await tester.pumpAndSettle();
    expect(find.text('User Dashboard'), findsOneWidget);
    expect(find.text('Welcome, Akash K'), findsOneWidget);
    expect(find.text('9876543210'), findsOneWidget);

    await tester.tap(find.text('Logout'));
    await tester.pumpAndSettle();
    expect(find.text('User Login'), findsOneWidget);
  });
}
