import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'dart:io';

import 'confirmed_image_page.dart';

class PickedImage extends StatelessWidget {
  final String imagePath;

  const PickedImage({Key? key, required this.imagePath}) : super(key: key);

  Future<void> _saveImageToGallery(String path) async{
    final result = await ImageGallerySaver.saveFile(path);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.file(
            File(imagePath),
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 40,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context); // Geri dönüş
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            right: 10,
            child: Positioned(
              right: 30,
              bottom: 30,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.green
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: IconButton(
                    icon: Icon(Icons.check, color: Colors.white),
                    onPressed: () async {
                      await _saveImageToGallery(imagePath);

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ConfirmedImage(imagePath: imagePath),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
