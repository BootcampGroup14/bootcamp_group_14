import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:bootcamp_group_14/api/gemini_service.dart';

class PhotoAnalyzeScreen extends StatefulWidget {
  @override
  _PhotoAnalyzeScreenState createState() => _PhotoAnalyzeScreenState();
}

class _PhotoAnalyzeScreenState extends State<PhotoAnalyzeScreen> {
  String? _imagePath;
  Map<String, dynamic>? _analysisResult;

  Future<void> _analyzePhoto() async {
    if (_imagePath != null) {
      final result = await Provider.of<GeminiAIService>(context, listen: false)
          .analyzeImage(_imagePath!);
      setState(() {
        _analysisResult = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Analysis'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _imagePath == null
                ? Text('No image selected.')
                : Image.file(File(_imagePath!)),
            ElevatedButton(
              onPressed: _analyzePhoto,
              child: Text('Analyze Photo'),
            ),
            _analysisResult == null
                ? Container()
                : Text('Analysis Result: ${_analysisResult.toString()}'),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final pickedFile =
              await ImagePicker().pickImage(source: ImageSource.camera);
          if (pickedFile != null) {
            setState(() {
              _imagePath = pickedFile.path;
            });
          }
        },
        child: Icon(Icons.camera),
      ),
    );
  }
}
