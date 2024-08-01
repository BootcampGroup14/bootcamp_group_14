import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiAIService {
  final String apiUrl = 'https://api.gemini.ai/analyze';
  final String apiKey = dotenv.env['API_KEY']!;

  Future<Map<String, dynamic>> analyzeImage(String imagePath) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey', // API anahtarı başlığa ekleniyor
      },
      body: jsonEncode(<String, String>{
        'image_path': imagePath,
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to analyze image');
    }
  }
}
