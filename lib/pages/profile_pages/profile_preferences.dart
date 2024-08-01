import 'package:flutter/material.dart';

class ProfilePreferences extends StatefulWidget {
  const ProfilePreferences({super.key});

  @override
  _ProfilePreferencesState createState() => _ProfilePreferencesState();
}

class _ProfilePreferencesState extends State<ProfilePreferences> {
  // List of preference levels for each taste
  List<int> preferenceLevels = List<int>.filled(5, 0);
  // List of selected cultural cuisine preferences
  List<bool> selectedCuisines = List<bool>.filled(6, false);
  // Selected cooking level
  String selectedCookingLevel = '';

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
        title: Text(
          'Profil',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              // Ayarlar butonuna basıldığında yapılacak işlemler
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Yemek Tercihleri',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 249,
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Tat tercihlerini işaretleyerek derecelerini belirtiniz.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: List.generate(5, (index) {
                  return TastePreferenceButton(
                    text: ['Tuzlu', 'Baharatlı', 'Ekşi', 'Tatlı', 'Acı'][index],
                    level: preferenceLevels[index],
                    onIncrease: () {
                      setState(() {
                        if (preferenceLevels[index] < 10) {
                          preferenceLevels[index]++;
                        }
                      });
                    },
                    onDecrease: () {
                      setState(() {
                        if (preferenceLevels[index] > 0) {
                          preferenceLevels[index]--;
                        }
                      });
                    },
                  );
                }),
              ),
              SizedBox(height: 20),
              Text(
                'Kültürel mutfak tercihlerini seçiniz.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 10),
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(6, (index) {
                  return CuisineCard(
                    text: ['Türk', 'Hint', 'Çin', 'İtalyan', 'Fransız', 'Kore'][index],
                    isSelected: selectedCuisines[index],
                    onTap: () {
                      setState(() {
                        selectedCuisines[index] = !selectedCuisines[index];
                      });
                    },
                  );
                }),
              ),
              SizedBox(height: 20),
              Text(
                'Yemek pişirme seviyesini seçiniz.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CookingLevelButton(
                    text: 'Kolay',
                    isSelected: selectedCookingLevel == 'Kolay',
                    onTap: () {
                      setState(() {
                        selectedCookingLevel = 'Kolay';
                      });
                    },
                  ),
                  CookingLevelButton(
                    text: 'Orta',
                    isSelected: selectedCookingLevel == 'Orta',
                    onTap: () {
                      setState(() {
                        selectedCookingLevel = 'Orta';
                      });
                    },
                  ),
                  CookingLevelButton(
                    text: 'Zor',
                    isSelected: selectedCookingLevel == 'Zor',
                    onTap: () {
                      setState(() {
                        selectedCookingLevel = 'Zor';
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: !isKeyboardVisible,
        child: Padding(
          padding: EdgeInsets.only(bottom: 0.0), // Yükseklik ayarlaması
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50), // Border radius
            child: FloatingActionButton(
              onPressed: () {
                // Kamera açma işlemleri yapılacak.
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.white, // Kamera ikonunun beyaz olması
              ),
              backgroundColor: Colors.black,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 8, // Gölgelendirme efekti için elevation ayarı
        color: Colors.white, // Barın rengi, beyazın bir tık daha koyusu
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home_outlined),
              iconSize: 28, // İkon boyutu
              onPressed: () {
                // Ana Sayfaya yönlendirme işlemleri yapılacak.
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite_border_outlined),
              iconSize: 28, // İkon boyutu
              onPressed: () {
                // Favoriler ekranına yönlendirme yapılacak.
              },
            ),
            SizedBox(width: 48),
            IconButton(
              icon: Icon(Icons.notifications_none_outlined),
              iconSize: 28, // İkon boyutu
              onPressed: () {
                // Bildirimler ekranına yönlendirme yapılacak.
              },
            ),
            IconButton(
              icon: Icon(Icons.person), // Aktif ekran olduğu için ikon değiştirilmiştirr.
              iconSize: 28, // İkon boyutu
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

class TastePreferenceButton extends StatelessWidget {
  final String text;
  final int level;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const TastePreferenceButton({
    required this.text,
    required this.level,
    required this.onIncrease,
    required this.onDecrease,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(Icons.remove),
            onPressed: onDecrease,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 102,
                height: 23,
                decoration: BoxDecoration(
                  color: Color(0xFFD9D9D9),
                  border: Border.all(color: Colors.black, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: (102 * (level / 10)).clamp(0.0, 102.0),
                height: 23,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Container(
                width: 102,
                height: 23,
                alignment: Alignment.center,
                child: Text(
                  text,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.add),
            onPressed: onIncrease,
          ),
        ],
      ),
    );
  }
}

class CuisineCard extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const CuisineCard({
    required this.text,
    required this.isSelected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 76,
        height: 76,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Color(0xFFD9D9D9),
          border: Border.all(color: isSelected ? Color(0xFF00EA09) : Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/cuisine_images/${text.toLowerCase()}.png',
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 5),
            Text(
              text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CookingLevelButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const CookingLevelButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 82,
        height: 23,
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: Color(0xFFD9D9D9),
          border: Border.all(color: isSelected ? Color(0xFF00EA09) : Colors.black, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
