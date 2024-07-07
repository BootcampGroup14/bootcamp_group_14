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
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              constraints: const BoxConstraints(
                //maxHeight:120, // Yüksekliği logonuzun boyutuna göre ayarlayın
                maxWidth: 120,
              ),
              child: Image.asset(
                'assets/QuestifyLogo-05.png', // Dosya adınızı doğru bir şekilde girin
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              child: Text(
                'Şifrenizi sıfırlamak için e-mail adresinizi girin',
                semanticsLabel:
                    'Şifrenizi sıfırlamak için e-mail adresinizi girin',
                style: TextStyle(
                    fontFamily: 'Roboto-Regular',
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextField(
              controller: _forgotPassTextController,
              labeltext: 'E-mail',
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
    );
  }
}
