import 'package:flutter/material.dart';
import 'dart:io';

class ConfirmedImage extends StatelessWidget {
  final String imagePath;

  const ConfirmedImage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Onaylandı'),
      ),
      body: Center(
        child: Image.file(File(imagePath)),
      ),
    );
  }
}