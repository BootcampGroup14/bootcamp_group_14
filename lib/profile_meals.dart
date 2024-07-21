import 'package:flutter/material.dart';

class MealAndPortionInfo extends StatefulWidget {
  const MealAndPortionInfo({super.key});

  @override
  _MealAndPortionInfoState createState() => _MealAndPortionInfoState();
}

class _MealAndPortionInfoState extends State<MealAndPortionInfo> {
  List<Map<String, dynamic>> mealInfo = List.generate(6, (index) => {
    'meal': ['Kahvaltı', 'Ara öğün', 'Öğle yemeği', 'Ara öğün', 'Akşam yemeği', 'Ara öğün'][index],
    'hour': 0,
    'minute': 0,
    'quantity': 1,
  });

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
                  'Öğün ve Porsiyon Bilgileri',
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
                'Öğün seçerek saat ve porsiyon bilgisini giriniz.',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: List.generate(6, (index) {
                  return MealRow(
                    meal: mealInfo[index]['meal'],
                    hour: mealInfo[index]['hour'],
                    minute: mealInfo[index]['minute'],
                    quantity: mealInfo[index]['quantity'],
                    onHourChanged: (newHour) {
                      if (newHour != null) {
                        setState(() {
                          mealInfo[index]['hour'] = newHour;
                        });
                      }
                    },
                    onMinuteChanged: (newMinute) {
                      if (newMinute != null) {
                        setState(() {
                          mealInfo[index]['minute'] = newMinute;
                        });
                      }
                    },
                    onIncrease: () {
                      setState(() {
                        mealInfo[index]['quantity']++;
                      });
                    },
                    onDecrease: () {
                      setState(() {
                        if (mealInfo[index]['quantity'] > 1) {
                          mealInfo[index]['quantity']--;
                        }
                      });
                    },
                  );
                }),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: !isKeyboardVisible,
        child: Padding(
          padding: EdgeInsets.only(bottom: 0.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: FloatingActionButton(
              onPressed: () {
                // Kamera açma işlemleri yapılacak.
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.white,
              ),
              backgroundColor: Colors.black,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        elevation: 8,
        color: Colors.white,
        shape: CircularNotchedRectangle(),
        notchMargin: 10.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home_outlined),
              iconSize: 28,
              onPressed: () {
                // Ana Sayfaya yönlendirme işlemleri yapılacak.
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite_border_outlined),
              iconSize: 28,
              onPressed: () {
                // Favoriler ekranına yönlendirme yapılacak.
              },
            ),
            SizedBox(width: 48),
            IconButton(
              icon: Icon(Icons.notifications_none_outlined),
              iconSize: 28,
              onPressed: () {
                // Bildirimler ekranına yönlendirme yapılacak.
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              iconSize: 28,
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

class MealRow extends StatelessWidget {
  final String meal;
  final int hour;
  final int minute;
  final int quantity;
  final ValueChanged<int?> onHourChanged;
  final ValueChanged<int?> onMinuteChanged;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;

  const MealRow({
    required this.meal,
    required this.hour,
    required this.minute,
    required this.quantity,
    required this.onHourChanged,
    required this.onMinuteChanged,
    required this.onIncrease,
    required this.onDecrease,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 100,  // Adjust width as needed
            decoration: BoxDecoration(
              color: Color(0xFFD9D9D9),
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              meal,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(width: 10),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: DropdownButton<int>(
                    value: hour,
                    items: List.generate(24, (index) => DropdownMenuItem(
                      value: index,
                      child: Text(index.toString().padLeft(2, '0')),
                    )),
                    onChanged: onHourChanged,
                    hint: Text('Hour'),
                    isExpanded: true,
                    isDense: true,  // Reduce padding
                  ),
                ),
                SizedBox(width: 5),
                Flexible(
                  child: DropdownButton<int>(
                    value: minute,
                    items: List.generate(60, (index) => DropdownMenuItem(
                      value: index,
                      child: Text(index.toString().padLeft(2, '0')),
                    )),
                    onChanged: onMinuteChanged,
                    hint: Text('Minute'),
                    isExpanded: true,
                    isDense: true,  // Reduce padding
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Container(
            width: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: onDecrease,
                ),
                Text(
                  quantity.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: onIncrease,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
