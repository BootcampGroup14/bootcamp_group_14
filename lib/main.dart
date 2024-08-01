import 'package:bootcamp_group_14/api/gemini_service.dart';
import 'package:bootcamp_group_14/pages/splash_screen.dart';
import 'package:bootcamp_group_14/theme/theme_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env"); // .env dosyasını yükle
    print("Dotenv loaded successfully");
  } catch (e) {
    print("Error loading dotenv: $e");
  }
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
        Provider<GeminiAIService>(
          create: (context) => GeminiAIService(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NeYesek?',
      theme: themeProvider.themeData,
      home: const SplashScreen(),
    );
  }
}
