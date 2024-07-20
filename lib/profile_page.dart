import 'package:bootcamp_group_14/camera_screen.dart';
import 'package:bootcamp_group_14/profile_edit_page.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    _initializeCameras();
  }

  Future<void> _initializeCameras() async {
    cameras = await availableCameras(); // Kameraları al
    setState(() {}); // Durumu güncelle
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 40),
            child: InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileEditPage()),
                );
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/profile_images/default_avatar.png',
                      width: 50,
                      height: 50,
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Group14',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          '@kullanıcıGroup14',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.all(16),
              children: [
                InkWell(
                  child: ProfileItem(
                    imagePath: 'assets/images/icons/heart-attack.png',
                    title: 'Sağlık Bilgileri',
                    onTap: () {
                      // Sağlık bilgileri sayfasına yönlendirme yapılacak.
                    },
                  ),
                ),
                InkWell(
                  child: ProfileItem(
                    imagePath: 'assets/images/icons/target.png',
                    title: 'Diyet ve Beslenme Hedefleri',
                    onTap: () {
                      // Diyet ve beslenme hedefleri sayfasına yönlendirme yapılacak.
                    },
                  ),
                ),
                InkWell(
                  child: ProfileItem(
                    imagePath: 'assets/images/icons/diet.png',
                    title: 'Öğün ve Porsiyon Bilgileri',
                    onTap: () {
                      // Öğün ve Porsiyon Bilgileri sayfasına yönlendirme yapılacak.
                    },
                  ),
                ),
                InkWell(
                  child: ProfileItem(
                    imagePath: 'assets/images/icons/salad.png',
                    title: 'Yemek Tercihleri',
                    onTap: () {
                      // Yemek Tercihleri sayfasına yönlendirme yapılacak.
                    },
                  ),
                ),
                InkWell(
                  child: ProfileItem(
                    imagePath: 'assets/images/icons/frying-pan.png',
                    title: 'Mutfak Ekipmanları',
                    onTap: () {
                      // Mutfak Ekipmanları sayfasına yönlendirme yapılacak.
                    },
                  ),
                ),
                InkWell(
                  child: ProfileItem(
                    imagePath: 'assets/images/icons/rice.png',
                    title: 'Mutfak Stokları',
                    onTap: () {
                      // Mutfak Stokları sayfasına yönlendirme yapılacak.
                    },
                  ),
                ),
                InkWell(
                  child: ProfileItem(
                    imagePath: 'assets/images/icons/cake.png',
                    title: 'Özel Gün ve Tatiller',
                    onTap: () {
                      // Özel gün ve tatiller sayfasına yönlendirme yapılacak.
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        child: FloatingActionButton(
          onPressed: () {
            if (cameras.isNotEmpty) { // Kameralar mevcutsa geçiş yap
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CameraScreen(camera: cameras.first),
                ),
              );
            }
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
              icon: Icon(Icons.person),
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

class ProfileItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback onTap;

  ProfileItem({required this.imagePath, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          decoration: BoxDecoration(
            color: Color.fromARGB(200, 247, 247, 249),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                width: 24,
                height: 24,
              ),
              SizedBox(width: 16),
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