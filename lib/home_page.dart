import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RecipeHomePage extends StatefulWidget {
  @override
  _RecipeHomePageState createState() => _RecipeHomePageState();
}

class _RecipeHomePageState extends State<RecipeHomePage> {
  final List<Map<String, dynamic>> popularRecipes = [
    {
      'title': 'Spaghetti',
      'image': 'assets/spaghetti.jpg',
      'username': 'John',
      'avatar': 'assets/avatar1.jpg',
      'cookingTime': 30
    },
    {
      'title': 'Tacos',
      'image': 'assets/tacos.jpg',
      'username': 'Jane',
      'avatar': 'assets/avatar2.jpg',
      'cookingTime': 20
    },
    {
      'title': 'Sushi',
      'image': 'assets/sushi.jpg',
      'username': 'Chef',
      'avatar': 'assets/avatar3.jpg',
      'cookingTime': 45
    },
  ];

  final List<Map<String, String>> recommendedRecipes = [
    {'title': 'Pizza', 'image': 'assets/pizza.jpg'},
    {'title': 'Salad', 'image': 'assets/salad.jpg'},
    {'title': 'Burger', 'image': 'assets/burger.jpg'},
  ];

  String selectedCategory = 'Sabah';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ana Sayfa',
          style: GoogleFonts.raleway(
            color: Color(0xFF0A2533),
            fontWeight: FontWeight.w700,
            fontSize: 24,
            height: 32 / 24,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF0A2533)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Text(
                'Popüler Tarifler',
                style: GoogleFonts.raleway(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A2533),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 260, // Adjusted height for popular recipes section
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularRecipes.length,
                  itemBuilder: (context, index) {
                    return RecipeCard(
                      title: popularRecipes[index]['title']!,
                      image: popularRecipes[index]['image']!,
                      backgroundColor: Color(0xFF3DA0A7),
                      username: popularRecipes[index]['username']!,
                      avatar: popularRecipes[index]['avatar']!,
                      cookingTime: popularRecipes[index]['cookingTime']!,
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Kategoriler',
                style: GoogleFonts.raleway(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A2533),
                ),
              ),
              SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCategory = 'Sabah';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedCategory == 'Sabah'
                            ? Color(0xFF5F8670)
                            : Color(0xFFF1F5F5),
                        fixedSize: Size(140, 40),
                      ),
                      child: Text(
                        'Sabah',
                        style: TextStyle(
                          color: selectedCategory == 'Sabah'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCategory = 'Öğle Yemeği';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedCategory == 'Öğle Yemeği'
                            ? Color(0xFF5F8670)
                            : Color(0xFFF1F5F5),
                        fixedSize: Size(140, 40),
                      ),
                      child: Text(
                        'Öğle Yemeği',
                        style: TextStyle(
                          color: selectedCategory == 'Öğle Yemeği'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedCategory = 'Akşam';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedCategory == 'Akşam'
                            ? Color(0xFF5F8670)
                            : Color(0xFFF1F5F5),
                        fixedSize: Size(140, 40),
                      ),
                      child: Text(
                        'Akşam',
                        style: TextStyle(
                          color: selectedCategory == 'Akşam'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Önerilen Tarifler',
                style: GoogleFonts.raleway(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0A2533),
                ),
              ),
              SizedBox(height: 10),
              Container(
                height: 200, // Adjusted height for recommended recipes section
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: recommendedRecipes.length,
                  itemBuilder: (context, index) {
                    return RecommendedRecipeCard(
                      title: recommendedRecipes[index]['title']!,
                      image: recommendedRecipes[index]['image']!,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeCard extends StatelessWidget {
  final String title;
  final String image;
  final Color? backgroundColor;
  final String? username;
  final String? avatar;
  final int? cookingTime;

  RecipeCard({
    required this.title,
    required this.image,
    this.backgroundColor,
    this.username,
    this.avatar,
    this.cookingTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170, // Adjusted width as needed
      height: 260, // Adjusted height as needed
      margin: const EdgeInsets.all(8.0),
      child: Card(
        color: backgroundColor ?? Colors.white,
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.asset(
                image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            if (username != null && avatar != null && cookingTime != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(avatar!),
                          radius: 12,
                        ),
                        SizedBox(width: 5),
                        Text(
                          username!,
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          FontAwesomeIcons.clock,
                          size: 12,
                        ),
                        SizedBox(width: 5),
                        Text(
                          '$cookingTime',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class RecommendedRecipeCard extends StatelessWidget {
  final String title;
  final String image;

  RecommendedRecipeCard({required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 240, // Adjusted width as needed
      height: 200, // Adjusted height as needed
      margin: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
