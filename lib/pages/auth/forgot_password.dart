import 'dart:math';
import 'package:bootcamp_group_14/components/my_button.dart';
import 'package:bootcamp_group_14/components/my_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _forgotPassTextController = TextEditingController();
  Future resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _forgotPassTextController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Şifre sıfırlama e-maili gönderildi.'),
        ),
      );
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Kullanıcı bulunamadı.'),
          ),
        );
      } else if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Geçersiz e-mail adresi.'),
          ),
        );
      }
    }
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: _forgotPassTextController.text.trim());
  }

  @override
  void dispose() {
    _forgotPassTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Login.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                      'Şifrenizi sıfırlamak için e-mail adresinizi girin',
                      semanticsLabel:
                          'Şifrenizi sıfırlamak için e-mail adresinizi girin',
                      style: TextStyle(
                        fontFamily: 'Roboto-Regular',
                        fontSize: 16,
                        color: Colors.white,
                      )),
                ),
                const SizedBox(
                  height: 10,
                ),
                MyTextField(
                  controller: _forgotPassTextController,
                  hintText: 'E-mail',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 10,
                ),
                MyButton(
                    onTap: resetPassword,
                    text: 'Şifremi Sıfırla',
                    semanticsLabel: 'Şifremi Sıfırla'),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
