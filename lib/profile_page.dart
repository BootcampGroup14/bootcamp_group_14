/* import 'package:bootcamp_group_14/pages/camera_pages/camera_screen.dart';
import 'package:bootcamp_group_14/pages/profile_pages/profile_edit_page_screen.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class ProfilePage2 extends StatefulWidget {
  @override
  _ProfilePage2State createState() => _ProfilePage2State();
}

class _ProfilePage2State extends State<ProfilePage2> {
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
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
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
    );
  }
}
 */