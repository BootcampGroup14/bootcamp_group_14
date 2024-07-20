import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RecipeDetailScreen extends StatefulWidget {
  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    'https://via.placeholder.com/400',
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 40,
                    left: 16,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 16,
                    child: IconButton(
                      icon: Icon(Icons.favorite_border, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.7,
            minChildSize: 0.7,
            maxChildSize: 0.85,
            builder: (BuildContext context, ScrollController scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            width: 40,
                            height: 6,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Sebzeli Omlet',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildInfoCard('6 porsiyon', Icons.people),
                            _buildInfoCard('15 dk', Icons.timer),
                            _buildInfoCard('Kolay', Icons.emoji_emotions),
                          ],
                        ),
                        SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildInfoCard('5.8g karb', Icons.rice_bowl),
                            _buildInfoCard('15.7g pro', Icons.local_dining),
                            _buildInfoCard('13.7g yağ', Icons.oil_barrel),
                            _buildInfoCard('204.5 kal', Icons.local_fire_department),
                          ],
                        ),
                        SizedBox(height: 16),
                        TabBar(
                          controller: _tabController,
                          indicatorColor: Colors.black,
                          labelColor: Colors.black,
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(text: "Malzemeler"),
                            Tab(text: "Hazırlanışı"),
                          ],
                        ),
                        SizedBox(
                          height: 300,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              _buildIngredientsTab(),
                              _buildPreparationTab(),
                            ],
                          ),
                        ),
                        SizedBox(height: 16),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {},
                            child: Text('Başka Tarif Öner'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String text, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 32),
        SizedBox(height: 4),
        Text(text),
      ],
    );
  }

  Widget _buildIngredientsTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIngredientItem('Yumurta', '8'),
            _buildIngredientItem('Kırmızı biber', '2'),
            _buildIngredientItem('Diş sarımsak', '2'),
            _buildIngredientItem('Cedar peyniri', '100g'),
            _buildIngredientItem('Ricotta peyniri', '50g'),
            _buildIngredientItem('Ispanak', '100g'),
            _buildIngredientItem('Cherry domates', '10'),
            _buildIngredientItem('Yeşil soğan', '3'),
            _buildIngredientItem('Tuz ve karabiber', 'tadında'),
          ],
        ),
      ),
    );
  }

  Widget _buildPreparationTab() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          '1. Yumurtaları bir kaseye kırın ve çırpın.\n'
              '2. Kırmızı biberleri doğrayın ve sarımsakları ince ince kıyın.\n'
              '3. Bir tavaya biraz yağ ekleyin ve biberleri, sarımsakları soteleyin.\n'
              '4. Ispanakları ekleyin ve birkaç dakika pişirin.\n'
              '5. Çırpılmış yumurtaları tavaya dökün ve karıştırarak pişirin.\n'
              '6. Omleti servis tabağına alın, üzerini cherry domatesler ve yeşil soğanla süsleyin.\n'
              '7. Tuz ve karabiber ekleyerek servis yapın.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildIngredientItem(String name, String quantity) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(name[0]),
      ),
      title: Text(name),
      trailing: Text(quantity),
    );
  }
}

