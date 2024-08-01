import 'package:bootcamp_group_14/api/gemini_ai_screen.dart';
import 'package:bootcamp_group_14/api/gemini_service.dart';
import 'package:bootcamp_group_14/pages/camera_pages/camera_screen.dart';
import 'package:bootcamp_group_14/pages/home_screen.dart';
import 'package:bootcamp_group_14/pages/profile_pages/profile_health_screen.dart';
import 'package:bootcamp_group_14/pages/profile_pages/profile_screen.dart';
import 'package:bootcamp_group_14/pages/saved_screen.dart';
import 'package:bootcamp_group_14/pages/settings_screen.dart';
import 'package:bootcamp_group_14/profile_page.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class MainNavigator extends StatefulWidget {
  const MainNavigator({super.key});

  @override
  State<MainNavigator> createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  int _currentIndex = 0;
  var currentUser;
  List<Widget> _pages = [];
  PageController _pageController = PageController(initialPage: 0);
  CameraDescription? _cameraDescription;

  @override
  void initState() {
    currentUser = FirebaseAuth.instance.currentUser!;
    super.initState();

    _initializeCamera().then((_) {
      setState(() {
        _pages = [
          RecipeHomePage(),
          PhotoAnalyzeScreen(),
          _cameraDescription != null
              ? CameraScreen(camera: _cameraDescription!)
              : Center(child: Text('Kamera bulunamadı')),
          const SettingsPage(),
          ProfilePage(),
        ];
      });
    });
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      _cameraDescription = cameras.isNotEmpty ? cameras.first : null;
    } catch (e) {
      print('Kamera başlatma hatası: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _currentIndex,
        height: 60.0,
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.search, size: 30),
          Icon(Icons.camera_alt, size: 30),
          Icon(Icons.settings, size: 30),
          Icon(Icons.person, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(112, 185, 190, 1),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            _pageController.jumpToPage(index);
          });
        },
      ),
    );
  }
}
