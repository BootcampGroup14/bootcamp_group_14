import 'package:bootcamp_group_14/auth/auth.dart';
import 'package:bootcamp_group_14/pages/password_reset.dart';
import 'package:bootcamp_group_14/pages/profile_edit_page_screen.dart';
import 'package:bootcamp_group_14/theme/theme_provider.dart';
import 'package:bootcamp_group_14/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void signOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuthPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    bool toggleTheme = themeProvider.themeData == darkTheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Ayarlar'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: themeProvider.toggleTheme,
            icon: Icon(toggleTheme ? Icons.dark_mode : Icons.light_mode),
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SettingsItem(
            icon: Icons.person,
            title: 'Profil Düzenleme',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileEditPage()),
              );
            },
          ),
          SettingsItem(
            icon: Icons.lock,
            title: 'Şifre Değiştirme',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ChangePassword()));
            },
          ),
          SettingsItem(
            icon: Icons.notifications,
            title: 'Bildirimler',
            onTap: () {
              // Bildirimler sayfasına yönlendirme yapılacak.
            },
          ),
          SettingsItem(
            icon: Icons.language,
            title: 'Dil',
            onTap: () {
              // Dil ayarları sayfasına yönlendirme yapılacak.
            },
          ),
          SettingsItem(
            icon: Icons.security,
            title: 'Güvenlik',
            onTap: () {
              // Güvenlik ayarları sayfasına yönlendirme yapılacak.
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 100),
            child: InkWell(
              onTap: () {
                // Logout işlemleri yapılacak. Ardından Login Sayfasına yönlendirme yapılacak.
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 247, 247, 249),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.exit_to_app, color: Colors.red),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        signOut(context);
                      },
                      child: const Text(
                        'Çıkış Yap',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  SettingsItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 15),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 247, 247, 249),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.black),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
