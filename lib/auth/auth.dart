import 'package:bootcamp_group_14/components/navigator.dart';
import 'package:bootcamp_group_14/pages/home_screen.dart';
import 'package:bootcamp_group_14/auth/login_or_register.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //Kullanıcı giriş yapabildiğinde
          if (snapshot.hasData) {
            return MainNavigator();
          }
          //Kullanıcı giriş yapamağında
          else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
