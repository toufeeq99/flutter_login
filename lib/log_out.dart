import 'package:flutter/material.dart';
import 'package:login_page/auth_screen.dart';

class LogOut extends StatelessWidget {
  const LogOut({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const AuthScreen()), // Navigate to HomePage
              );
            },
            child: const Text(
              'Log out',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            )),
      ),
    );
  }
}
