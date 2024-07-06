import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom != 0;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Profil Düzenleme'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 75,
              backgroundImage: AssetImage('assets/images/profile_images/default_avatar.png'), // Profil resmi için bir yer tutucu
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Kullanıcı Adı', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700])),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('E-Posta Adresi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[700])),
                  SizedBox(height: 8),
                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 80.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Güncelle', style: TextStyle(color: Colors.black)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 247, 247, 249),
                  minimumSize: Size(double.infinity, 50), // Butonun genişliğini ayarlamak için kullanıyoruz.
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Visibility(
        visible: !isKeyboardVisible,
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
              icon: Icon(Icons.person), // Aktif ekran olduğu için ikon değiştirilmiştir.
              onPressed: () {
                // Profil ekranına yönlendirme yapılacak.
              },
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
