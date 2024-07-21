import 'package:bootcamp_group_14/components/my_button.dart';
import 'package:bootcamp_group_14/pages/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';

enum Gender { Erkek, Kadin, Diger }

class RegisterScreen extends StatefulWidget {
  final Function()? onTap;
  const RegisterScreen({super.key, required this.onTap});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  //text editing controllers
  final emailTextController = TextEditingController();
  final passowordTextController = TextEditingController();
  final passowordConfirmTextController = TextEditingController();
  final userNameTextController = TextEditingController();
  bool isObscured = true;
  bool isObscuredConfirm = true;
  Gender? selectedGender;
  String selectedGenderText = '';
  bool _isClicked = false;
  //kayıt olma
  String getFirebaseAuthErrorMessage(String errorCode, BuildContext context) {
    switch (errorCode) {
      case 'email-already-in-use':
        return "Bu e-posta adresi zaten kullanılıyor. Lütfen başka bir e-posta adresi deneyin.";
      case 'weak-password':
        return "Girdiğiniz şifre çok zayıf. Lütfen daha güçlü bir şifre seçin.";
      case 'operation-not-allowed':
        return "Kayıt işlemi şu anda kullanılamıyor. Lütfen daha sonra tekrar deneyin.";
      default:
        return "Bilinmeyen bir hata oluştu. Lütfen daha sonra tekrar deneyin."; // Bu, tanımlanamayan hatalar için varsayılan mesajdır.
    }
  }

  Future signUp() async {
    // Yükleme Ekranı
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    //Şifre eşleşme kontrolü
    if (passowordTextController.text != passowordConfirmTextController.text) {
      //yükleme ekranını kapama
      Navigator.pop(context);
      //hata mesajı
      ScaffoldMessenger.of(context).showSnackBar(
        //Hata mesajı göster
        displayMessage('Şifreler eşleşmiyor.'),
      );
      setState(() {
        _isClicked = false;
      });
      return;
    } else {
      if (passowordTextController.text.length < 6) {
        Navigator.pop(context);
        //hata mesajı
        ScaffoldMessenger.of(context).showSnackBar(
          //Hata mesajı göster
          displayMessage(
              'Şifre uzunluğu çok kısa. En az 6 karakter olmalıdır.'),
        );
        setState(() {
          _isClicked = false;
        });
        return;
      }
      if (usernameControlValue == 1 && emailControlValue == 2) {
        try {
          //Kayıt Olma
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
                  email: emailTextController.text.trim(),
                  password: passowordTextController.text);

          // E-posta doğrulama gönderilecek
          User? user = FirebaseAuth.instance.currentUser;
          await user?.sendEmailVerification();

          //Kayıt olduktan sonra firestore'a kayıt etme
          FirebaseFirestore.instance
              .collection('Users')
              .doc(userCredential.user!.email!.trim())
              .set({
            'username': userNameTextController.text,
          });
          //Kullanıcı Adı Listesi Ekleme
          DocumentReference postRef = FirebaseFirestore.instance
              .collection('UserNames')
              .doc('usernames');
          postRef.update({
            'usernames': FieldValue.arrayUnion([userNameTextController.text])
          });
        } on FirebaseAuthException catch (e) {
          final String errorMessage =
              getFirebaseAuthErrorMessage(e.code, context);
          //yükleme indicatorını kapatma
          ScaffoldMessenger.of(context).showSnackBar(
            //Hata mesajı göster
            SnackBar(
              content: Text(errorMessage),
            ),
          );
        }
      } else if (usernameControlValue != 1) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            //Hata mesajı göster
            displayMessage(
                'Kullanıcı adı mevcut. Farklı bir kullanıcı adı giriniz.'));
        setState(() {
          _isClicked = false;
        });
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
            //Hata mesajı göster
            displayMessage('Geçerli bir mail adresi giriniz.'));
        setState(() {
          _isClicked = false;
        });
      }
    }
  }

  //Hata mesajı gösterme
  SnackBar displayMessage(String message) {
    return SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 3),
    );
  }

  List<dynamic> usernames = [];
  int usernameControlValue = 0;
  void getDocumentData() async {
    String documentPath = 'UserNames/usernames';
    // Firestore belgesini belirtilen yoldan alın
    DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await FirebaseFirestore.instance.doc(documentPath).get();
    Map<String, dynamic>? doc = documentSnapshot.data();
    usernames = doc?['usernames'];
  }

  void controlUsername(String username) {
    if (usernames.contains(username)) {
      setState(() {
        usernameControlValue = 2;
      });
    } else if (!username.isEmpty) {
      setState(() {
        usernameControlValue = 1;
      });
    } else {
      setState(() {
        usernameControlValue = 0;
      });
    }
  }

  int emailControlValue = 0;

  void controlEmail(String email) {
    if (RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(email)) {
      setState(() {
        emailControlValue = 2;
      });
    } else if (!email.isEmpty) {
      setState(() {
        emailControlValue = 1;
      });
    } else {
      setState(() {
        emailControlValue = 0;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    userNameTextController.addListener(() {
      String text = userNameTextController.text.toLowerCase();
      if (text != userNameTextController.text) {
        userNameTextController.text = text;
        userNameTextController.selection = TextSelection.fromPosition(
          TextPosition(offset: userNameTextController.text.length),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    getDocumentData();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Login.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: ListView(
            children: [
              Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 150),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'KAYIT',
                        style: TextStyle(
                            fontFamily: 'Roboto-Medium',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 25),
                      const Text(
                        'Hesap oluşturmak için lütfen detayları doldurun.',
                        style: TextStyle(
                            fontFamily: 'Roboto-Medium',
                            fontSize: 16,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      // username textfield
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14)),
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Roboto-Medium',
                          ),
                          controller: userNameTextController,
                          onChanged: (value) => controlUsername(value),
                          cursorColor:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimary, // Normal durumda alt çizgi rengi
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: usernameControlValue == 1
                                    ? Colors.green
                                    : Theme.of(context)
                                        .colorScheme
                                        .secondary, // Odaklanıldığında alt çizgi rengi
                              ),
                            ),
                            errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .red, // Hata durumunda alt çizgi rengi
                              ),
                            ),
                            focusedErrorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors
                                    .red, // Odaklanıldığında ve hata varsa alt çizgi rengi
                              ),
                            ),
                            errorText: usernameControlValue == 2
                                ? 'Kullanıcı adı mevcut'
                                : null, // Hata mesajı
                            hintText: 'Ad Soyad',
                            labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            fillColor: Colors.transparent,
                            filled: true,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                      //email texfield
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14)),
                        child: TextField(
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontFamily: 'Roboto-Medium',
                          ),
                          cursorColor:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          controller: emailTextController,
                          onChanged: (value) => controlEmail(value),
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            hintText: 'E-mail',
                            labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
                            errorText:
                                emailControlValue == 0 || emailControlValue == 2
                                    ? null
                                    : 'Geçerli bir e-mail adresi giriniz.',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: emailControlValue == 0
                                    ? Theme.of(context).colorScheme.onPrimary
                                    : emailControlValue == 1
                                        ? Colors.red
                                        : Colors.green,
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: emailControlValue == 0
                                    ? Theme.of(context).colorScheme.secondary
                                    : emailControlValue == 1
                                        ? Colors.red
                                        : Colors.green,
                              ),
                            ),
                            fillColor: Colors
                                .transparent, // Arka plan rengi transparan olarak ayarlandı
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //password texfield
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14)),
                        child: TextField(
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontFamily: 'Roboto-Medium',
                          ),
                          cursorColor:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          controller: passowordTextController,
                          obscureText: isObscured,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: IconButton(
                              icon: Icon(
                                isObscured
                                    ? Icons.visibility_off
                                    : Icons
                                        .visibility, // İkon durumunu güncelle
                                color: Colors.black, // İkonun rengi
                              ),
                              onPressed: () {
                                setState(() {
                                  isObscured =
                                      !isObscured; // Şifre görünürlüğünü değiştir
                                });
                              },
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.onPrimary,
                              ), // Normal durumda alt çizgi rengi
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: Theme.of(context).colorScheme.secondary,
                              ), // Odaklanıldığında alt çizgi rengi
                            ),
                            hintText: 'Şifre',
                            labelStyle: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            fillColor: Colors.transparent,
                            filled: true, // Arka plan doldurulmasın
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Şifreniz 6 karakterli olmalı.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),

                      const SizedBox(height: 5),
                      //passord confirm textfield
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14)),
                        child: TextField(
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontFamily: 'Roboto-Medium',
                          ),
                          cursorColor:
                              Theme.of(context).colorScheme.onPrimaryContainer,
                          controller: passowordConfirmTextController,
                          obscureText: isObscuredConfirm,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: IconButton(
                              icon: Icon(
                                isObscuredConfirm
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  isObscuredConfirm = !isObscuredConfirm;
                                });
                              },
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      Theme.of(context).colorScheme.secondary),
                            ),
                            hintText: 'Şifre Doğrulama',
                            labelStyle: TextStyle(
                                color: Theme.of(context).colorScheme.secondary),
                            fillColor: Colors.transparent,
                            filled: true,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //sign in button
                      !_isClicked
                          ? MyButton(
                              semanticsLabel: 'Kayıt Ol',
                              onTap: () {
                                setState(() {
                                  _isClicked = true;
                                });
                                signUp();
                                Navigator.pop(context);
                              },
                              text: 'Kayıt Ol')
                          : const CircularProgressIndicator(),
                      const SizedBox(height: 20),
                      //go to register page
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Bir hesabınız var mı? ',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          Semantics(
                            button: true,
                            label: 'Giriş yap',
                            child: GestureDetector(
                              onTap: widget.onTap,
                              child: const Text(
                                'Giriş yap',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
