import 'package:bootcamp_group_14/auth/auth_pages/login_screen.dart';
import 'package:bootcamp_group_14/auth/auth_pages/register_screen.dart';
import 'package:flutter/material.dart';

class LoginOrRegister extends StatefulWidget {
  const LoginOrRegister({super.key});

  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  //başlangıç olarak giriş sayfasını göster
  bool showLoginPage = true;

  //Login register fonksiyonları arası geçiş
  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginScreen(onTap: togglePages);
    } else {
      return RegisterScreen(onTap: togglePages);
    }
  }
}
