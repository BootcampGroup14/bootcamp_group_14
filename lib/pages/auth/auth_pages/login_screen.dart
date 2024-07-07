import 'package:bootcamp_group_14/components/my_button.dart';
import 'package:bootcamp_group_14/components/my_text_field.dart';
import 'package:bootcamp_group_14/pages/auth/forgot_password.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bootcamp_group_14/pages/auth/auth.dart';
import 'package:bootcamp_group_14/pages/auth/sing_in_anonymosly.dart/sign_in_any.dart';
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
        child: Image.asset('lib/animations/loading2.gif'),
      ),
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text);
      //yükleme indicatorını kapatma
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException {
      //yükleme indicatorını kapatma
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        //Hata mesajı göster
        displayMessage('E-mail veya şifre yanlış.'),
      );
    }
  }

  SnackBar displayMessage(String message) {
    return SnackBar(
      content: Text(message),
      duration:
          const Duration(seconds: 3), // Snackbar ne kadar süre görüntülenecek?
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
                    '', // LOGO EKLENECEK
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'H O Ş  G E L D İ N İ Z',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontFamily: 'Roboto-Medium',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                const SizedBox(height: 25),

                //email texfield
                MyTextField(
                    controller: emailTextController,
                    labeltext: 'E-mail',
                    obscureText: false),

                const SizedBox(
                  height: 10,
                ),
                //password texfield
                MyTextField(
                    isLogin: true,
                    controller: passwordTextController,
                    labeltext: 'Şifre',
                    obscureText: true),

                const SizedBox(height: 10),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(
                          checkColor:
                              Theme.of(context).colorScheme.onBackground,
                          activeColor: Theme.of(context).colorScheme.secondary,
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
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontFamily: 'Roboto-Medium.ttf'),
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
                            fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                //sign in button
                MyButton(
                  onTap: () {
                    // Giriş yap butonuna tıklandığında
                    if (rememberMe) {
                      _saveUserCredentials();
                    }
                    signIn();
                  },
                  text: 'Giriş Yap',
                  semanticsLabel: 'Giriş Yap',
                ),
                const SizedBox(height: 20),
                //go to register page
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hesabınız yok mu? ',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Kayıt ol',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.blue),
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
                          builder: (context) => const AuthPage(),
                        ),
                      );
                    }
                  },
                  child: Text('Misafir girişi için tıklayınız.',
                      style: TextStyle(
                        color: Colors.blue,
                        fontFamily: 'Roboto-Medium.ttf',
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
