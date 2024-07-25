import 'package:bootcamp_group_14/auth/auth_pages/login_screen.dart';
import 'package:bootcamp_group_14/auth/auth_pages/register_screen.dart';
import 'package:bootcamp_group_14/auth/forgot_password.dart';
import 'package:bootcamp_group_14/auth/login_or_register.dart';
import 'package:bootcamp_group_14/camera_screen.dart';
import 'package:bootcamp_group_14/pages/home_screen.dart';
import 'package:bootcamp_group_14/pages/password_reset.dart';
import 'package:bootcamp_group_14/pages/profile_edit_page_screen.dart';
import 'package:bootcamp_group_14/pages/profile_health_screen.dart';
import 'package:bootcamp_group_14/pages/saved_screen.dart';
import 'package:bootcamp_group_14/pages/settings_screen.dart';
import 'package:bootcamp_group_14/pages/splash_screen.dart';
import 'package:bootcamp_group_14/profile_meals.dart';
import 'package:bootcamp_group_14/profile_page.dart';
import 'package:bootcamp_group_14/profile_preferences.dart';
import 'package:bootcamp_group_14/profile_diete.dart';
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
