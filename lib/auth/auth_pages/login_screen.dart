import 'package:bootcamp_group_14/components/my_button.dart';
import 'package:bootcamp_group_14/components/my_text_field.dart';
import 'package:bootcamp_group_14/pages/home_screen.dart';
import 'package:bootcamp_group_14/auth/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bootcamp_group_14/auth/auth.dart';
import 'package:bootcamp_group_14/auth/sing_in_anonymosly.dart/sign_in_any.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  final Function()? onTap;
  const LoginScreen({super.key, this.onTap});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //text editing controllers

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  bool rememberMe = true;

  //Kullanıcı giriş yaptığında
  void signIn() async {
    // Yükleme Ekranı
    showDialog(
      context: context,
      builder: (context) => Center(
        child: Image.asset('assets/splash_screen_white.jpg'), // EKLENECEK
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);

      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        displayMessage('E-mail veya şifre yanlış.'),
      );
    }
  }

  SnackBar displayMessage(String message) {
    return SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void initState() {
    _loadUserCredentials();
    super.initState();
  }

  // Kullanıcı bilgilerini kaydet
  Future<void> _saveUserCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('username', emailTextController.text);
    prefs.setString('password', passwordTextController.text);
    prefs.setBool('rememberMe', rememberMe);
  }

  // Kullanıcı bilgilerini yükle
  Future<void> _loadUserCredentials() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    emailTextController.text = prefs.getString('username') ?? '';
    passwordTextController.text = prefs.getString('password') ?? '';
    rememberMe = prefs.getBool('rememberMe') ?? true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //logo
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    //maxHeight:120, //
                    maxWidth: 120,
                  ),
                  child: Image.asset(
                    'assets/NeYesekLogo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'GİRİŞ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 25),
                const Text(
                  'Devam etmek için lütfen giriş yapınız.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                const SizedBox(height: 25),
                //email texfield
                MyTextField(
                    controller: emailTextController,
                    hintText: 'E-mail',
                    obscureText: false),

                const SizedBox(
                  height: 10,
                ),
                //password texfield
                MyTextField(
                    isLogin: true,
                    controller: passwordTextController,
                    hintText: 'Şifre',
                    obscureText: true),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          checkColor: Colors.white,
                          activeColor: Colors.green,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          value: rememberMe,
                          onChanged: (bool? value) {
                            setState(() {
                              rememberMe = value!;
                            });
                          },
                        ),
                        Text(
                          'Beni Hatırla',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPassword(),
                          ),
                        );
                      },
                      child: const Text(
                        'Şifremi unuttum',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                MyButton(
                  onTap: () {
                    if (rememberMe) {
                      _saveUserCredentials();
                    }
                    signIn();
                  },
                  text: 'Giriş',
                  semanticsLabel: 'Giriş',
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hesabınız yok mu? ',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Kaydol',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    User? user = await signInAnonymously();
                    if (user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RecipeHomePage(),
                        ),
                      );
                    }
                  },
                  child: const Text('Misafir girişi için tıklayınız.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: '',
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
