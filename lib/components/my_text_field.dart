import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labeltext;
  bool obscureText;
  final IconData? suffixIcon;
  final bool isLogin;

  MyTextField(
      {super.key,
      required this.controller,
      required this.labeltext,
      required this.obscureText,
      this.isLogin = false,
      this.suffixIcon});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool isObscured = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
      ),
      controller: widget.controller,
      obscureText: widget.obscureText,
      cursorColor: Theme.of(context).colorScheme.onPrimaryContainer,
      decoration: InputDecoration(
        labelText: widget.labeltext,
        labelStyle: TextStyle(
            color: Theme.of(context)
                .colorScheme
                .secondary // Burası odaklanılmadığında etiket rengi
            ),
        floatingLabelBehavior:
            FloatingLabelBehavior.always, // Etiket her zaman görünür
        // Etkin olmayan durum için alt çizgi rengi:
        enabledBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.onPrimary),
        ),
        // Odaklanıldığında alt çizgi rengi:
        focusedBorder: UnderlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        suffixIcon: widget.isLogin
            ? IconButton(
                icon: Icon(
                  isObscured
                      ? Icons.visibility_off
                      : Icons.visibility, // İkon durumunu güncelle
                  color:
                      Theme.of(context).colorScheme.secondary, // İkonun rengi
                ),
                onPressed: () {
                  setState(() {
                    isObscured = !isObscured; // Şifre görünürlüğünü değiştir
                    widget.obscureText = !widget.obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
