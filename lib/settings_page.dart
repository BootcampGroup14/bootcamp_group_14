import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Ayarlar'),
        centerTitle: true,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          SettingsItem(
            icon: Icons.person,
            title: 'Profil Düzenleme',
            onTap: () {
              // Profil Düzenleme sayfasına yönlendirme yapılacak.
            },
          ),
          SettingsItem(
            icon: Icons.lock,
            title: 'Şifre Değiştirme',
            onTap: () {
              // Şifre Değiştirme sayfasına yönlendirme yapılacak.
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
            padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 100),
            child: InkWell(
              onTap: () {
                // Logout işlemleri yapılacak. Ardından Login Sayfasına yönlendirme yapılacak.
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255,247,247,249),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.exit_to_app, color: Colors.red),
                    SizedBox(width: 10),
                    Text(
                      'Çıkış Yap',
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        child: FloatingActionButton(
          onPressed: () {
            // Kamera açma işlemleri yapılacak.
          },
          child: Icon(Icons.camera_alt),
          backgroundColor: Colors.grey[300],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home_outlined),
              onPressed: () {
                // Ana Sayfaya yönlendirme işlemleri yapılacak.
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite_border_outlined),
              onPressed: () {
                // Favoriler ekranına yönlendirme yapılacak.
              },
            ),
            SizedBox(width: 48),
            IconButton(
              icon: Icon(Icons.notifications_none_outlined),
              onPressed: () {
                // Bildirimler ekranına yönlendirme yapılacak.
              },
            ),
            IconButton(
              icon: Icon(Icons.person_2_outlined),
              onPressed: () {
                // Profil ekranına yönlendirme yapılacak.
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  SettingsItem({required this.icon, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0,horizontal: 20),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
          decoration: BoxDecoration(
            color: Color.fromARGB(255,247,247,249),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.black),
              SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
