import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SavedRecipesPage extends StatelessWidget {
  final List<Map<String, dynamic>> savedRecipes = [
    {'name': 'Spaghetti Carbonara', 'image': 'assets/spaghetti.jpg'},
    {'name': 'Chicken Curry', 'image': 'assets/chicken_curry.jpg'},
    {'name': 'Chocolate Cake', 'image': 'assets/chocolate_cake.jpg'},
    {'name': 'Caesar Salad', 'image': 'assets/caesar_salad.jpg'},
    {'name': 'Pasta Primavera', 'image': 'assets/pasta_primavera.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Kaydedilenler',
          style: GoogleFonts.raleway(
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(120),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Color(0xFFE6EBF2), width: 2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Arama',
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    onChanged: (value) {
                      // Implement search logic here
                    },
                  ),
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CategoryButton(
                    label: 'Kahvaltı',
                    onTap: () {
                      // Handle Kahvaltı category tap
                    },
                  ),
                  CategoryButton(
                    label: 'Öğle Yemeği',
                    onTap: () {
                      // Handle Öğle Yemeği category tap
                    },
                  ),
                  CategoryButton(
                    label: 'Akşam',
                    onTap: () {
                      // Handle Akşam category tap
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: savedRecipes.length,
          itemBuilder: (context, index) {
            return SavedRecipeCard(
              name: savedRecipes[index]['name'],
              image: savedRecipes[index]['image'],
              onTap: () {
                // Navigate to recipe details page
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        RecipeDetailsPage(recipe: savedRecipes[index]),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class CategoryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const CategoryButton({
    required this.label,
    required this.onTap,
  });

  @override
  _CategoryButtonState createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _isSelected = !_isSelected;
        });
        widget.onTap();
      },
      child: Text(widget.label),
      style: ElevatedButton.styleFrom(
        backgroundColor: _isSelected ? Color(0xFF70B9BE) : Color(0xFFF1F5F5),
        textStyle: TextStyle(
          fontSize: 16,
          color: Color(0xFF0A2533),
          fontWeight: FontWeight.w400,
          fontFamily: GoogleFonts.raleway().fontFamily,
        ),
      ),
    );
  }
}

class SavedRecipeCard extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback onTap;

  const SavedRecipeCard({
    required this.name,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: onTap,
          child: Row(
            children: [
              SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  name,
                  style: GoogleFonts.raleway(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                width: 24,
                height: 24,
                color: Colors.black,
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 18,
                ),
              ), // Right arrow icon
            ],
          ),
        ),
      ),
    );
  }
}

class RecipeDetailsPage extends StatelessWidget {
  final Map<String, dynamic> recipe;

  const RecipeDetailsPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe['name']),
      ),
      body: Center(
        child: Text('Recipe Details Page for ${recipe['name']}'),
      ),
    );
  }
}
