import 'package:Eventlyst/pages/home_page.dart';
import 'package:Eventlyst/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:Eventlyst/pages/signup_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              return HomePage(); // Navigate to the HomePage for authenticated users.
            } else {
              return LoginPage(); // Navigate to the LoginPage for unauthenticated users.
            }
          }
        },
      ),
    );
  }
}
