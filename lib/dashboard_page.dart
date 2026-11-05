import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';

/// Shown after a successful login.
class DashboardPage extends StatelessWidget {
  final Map<String, dynamic> user;
  final FirebaseFirestore? firestore;

  const DashboardPage({super.key, required this.user, this.firestore});

  @override
  Widget build(BuildContext context) {
    final name = '${user['name'] ?? ''}';
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),
      appBar: AppBar(
        title: const Text('User Dashboard'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Card(
            margin: const EdgeInsets.all(24),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  child: Text(name.isNotEmpty ? name[0].toUpperCase() : 'U',
                      style: const TextStyle(fontSize: 28)),
                ),
                const SizedBox(height: 16),
                Text('Welcome, $name',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Text('You have logged in successfully'),
                const Divider(height: 32),
                ListTile(
                  leading: const Icon(Icons.email, color: Colors.teal),
                  title: const Text('Email'),
                  subtitle: Text('${user['email'] ?? ''}'),
                ),
                ListTile(
                  leading: const Icon(Icons.phone, color: Colors.teal),
                  title: const Text('Phone'),
                  subtitle: Text('${user['phone'] ?? ''}'),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    // Logout: clear the navigation stack and go back to login.
                    onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => LoginPage(firestore: firestore)),
                      (route) => false,
                    ),
                    icon: const Icon(Icons.logout),
                    label: const Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
