import 'package:bootcamp_group_14/model/recipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addRecipeToFirebase(Recipe recipe) async {
    await _firestore.collection('recipes').add(recipe.toMap());
  }

  Future<List<Recipe>> fetchRecipesFromFirebase() async {
    final snapshot = await _firestore.collection('recipes').get();
    return snapshot.docs
        .map((doc) => Recipe.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
