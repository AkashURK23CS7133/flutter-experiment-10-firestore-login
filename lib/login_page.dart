import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'dashboard_page.dart';

/// Login screen. Looks the user up in the Firestore "users" collection
/// (fields: name, email, phone, password) and compares the password.
///
/// ⚠️ Lab demonstration only – plaintext passwords + client-side checking
/// are insecure. See the warning in main.dart and README.md.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key, this.firestore});

  /// Optional override (used by tests with a fake Firestore).
  final FirebaseFirestore? firestore;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final email = TextEditingController();
  final password = TextEditingController();
  bool obscure = true, loading = false;
  String error = '';

  FirebaseFirestore get _db => widget.firestore ?? FirebaseFirestore.instance;

  Future<void> login() async {
    final enteredEmail = email.text.trim();
    final enteredPassword = password.text;
    if (enteredEmail.isEmpty || enteredPassword.isEmpty) {
      setState(() => error = 'Please enter email and password');
      return;
    }
    setState(() {
      loading = true;
      error = '';
    });
    try {
      // Fetch the user by email, then compare the stored password.
      final result = await _db
          .collection('users')
          .where('email', isEqualTo: enteredEmail)
          .get();

      Map<String, dynamic>? user;
      for (final doc in result.docs) {
        if ('${doc.data()['password']}' == enteredPassword) {
          user = doc.data();
          break;
        }
      }

      if (!mounted) return;
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => DashboardPage(user: user!, firestore: widget.firestore),
          ),
        );
      } else {
        setState(() => error = 'Invalid email or password');
      }
    } catch (e) {
      if (mounted) setState(() => error = 'Unable to login. Please try again. ($e)');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: const Color(0xFFF5F8FA),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.forum, size: 80, color: Colors.teal),
                  const SizedBox(height: 24),
                  const Text('User Login',
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Sign in with your email and password'),
                  const SizedBox(height: 32),
                  TextField(
                    key: const Key('emailField'),
                    controller: email,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    key: const Key('passwordField'),
                    controller: password,
                    obscureText: obscure,
                    onSubmitted: (_) => login(),
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
                        onPressed: () => setState(() => obscure = !obscure),
                      ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 28),
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: loading ? null : login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        foregroundColor: Colors.white,
                      ),
                      child: loading
                          ? const CircularProgressIndicator()
                          : const Text('Login'),
                    ),
                  ),
                  if (error.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        border: Border.all(color: Colors.red.shade200),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(children: [
                        const Icon(Icons.error_outline, color: Colors.red, size: 18),
                        const SizedBox(width: 8),
                        Expanded(
                            child: Text(error, style: const TextStyle(color: Colors.red))),
                      ]),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      );
}
