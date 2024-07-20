import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  bool obscureText;
  final IconData? suffixIcon;
  final bool isLogin;

  MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.isLogin = false,
    this.suffixIcon,
  });

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool isObscured = true;

  @override
  void initState() {
    super.initState();
    isObscured = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        color: Theme.of(context).colorScheme.secondary,
      ),
      controller: widget.controller,
      obscureText: isObscured,
      cursorColor: Theme.of(context).colorScheme.onPrimaryContainer,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: Colors.grey[600], // Placeholder color
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        suffixIcon: widget.isLogin
            ? IconButton(
                icon: Icon(
                  isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                onPressed: () {
                  setState(() {
                    isObscured = !isObscured;
                  });
                },
              )
            : null,
      ),
    );
  }
}
