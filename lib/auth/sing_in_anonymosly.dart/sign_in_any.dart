import 'package:firebase_auth/firebase_auth.dart';


Future<User?> signInAnonymously() async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInAnonymously();
    return userCredential.user;
  } catch (e) {
    print(e); // Hata yönetimi için
    return null;
  }
}