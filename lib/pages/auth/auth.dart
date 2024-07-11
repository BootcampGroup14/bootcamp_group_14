import 'package:bootcamp_group_14/home_page.dart';
import 'package:bootcamp_group_14/pages/auth/login_or_register.dart';
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
            return RecipeHomePage();
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
