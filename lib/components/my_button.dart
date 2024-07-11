import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final String semanticsLabel; // Erişilebilirlik etiketi için ekledik

  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
    required this.semanticsLabel,
    // Constructor'a etiketi ekledik
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true, // Bu widget bir düğme olduğunu belirtir.
      label: semanticsLabel, // Ekran okuyucusunun okuyacağı etiket.
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.green.shade800,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
