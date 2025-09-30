import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get current user!
  User? get currentUser => _auth.currentUser;

  // auth state stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // sign in
  Future<User?> signIn(String email, String password) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user;
    } catch (e) {
      rethrow;
    }
  }

 // Update the register function to include className
Future<User?> register(
  String email, 
  String password, 
  String name, 
  String role, 
  {String? className}
) async {
  try {
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    // Save user data to Firestore
    Map<String, dynamic> userData = {
      'name': name,
      'email': email,
      'role': role,
      'createdAt': FieldValue.serverTimestamp(),
    };
    
    // Add class if provided
    if (className != null) {
      userData['class'] = className;
    }
    
    await _firestore.collection('users').doc(credential.user!.uid).set(userData);
    
    return credential.user;
  } catch (e) {
    rethrow;
  }
}

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
