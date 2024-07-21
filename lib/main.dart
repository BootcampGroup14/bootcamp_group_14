import 'package:bootcamp_group_14/home_page.dart';
import 'package:bootcamp_group_14/pages/splash_screen.dart';
import 'package:bootcamp_group_14/profile_health.dart';
import 'package:bootcamp_group_14/profile_meals.dart';
import 'package:bootcamp_group_14/profile_page.dart';
import 'package:bootcamp_group_14/profile_preferences.dart';
import 'package:bootcamp_group_14/saved_page.dart';
import 'package:bootcamp_group_14/profile_diete.dart';
import 'package:bootcamp_group_14/profile_edit_page.dart';
import 'package:bootcamp_group_14/saved_page.dart';
import 'package:bootcamp_group_14/settings_page.dart';
import 'package:bootcamp_group_14/sifremiUnuttum.dart';
import 'package:bootcamp_group_14/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:bootcamp_group_14/recipe_details_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: MyApp(),
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
      home: SplashScreen(),
    );
  }
}
