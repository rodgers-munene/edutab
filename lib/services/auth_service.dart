import 'package:edutab/models/user_model.dart';
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
  Future<UserModel?> register(
  String email,
  String password,
  String name,
  String role,
  String className,
) async {
  try {
    // 1. Register user with Firebase Auth
    final credential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = credential.user!.uid;

    // 2. Save user data to Firestore
    final userData = {
      'name': name,
      'email': email,
      'role': role,
      'className': className,
      'createdAt': FieldValue.serverTimestamp(),
    };

    await _firestore.collection('users').doc(uid).set(userData);

    // 3. If student, add to class
    if (role == 'student' && className.isNotEmpty) {
      final classQuery = await _firestore
          .collection('classes')
          .where('className', isEqualTo: className)
          .limit(1)
          .get();

      if (classQuery.docs.isNotEmpty) {
        final classDoc = classQuery.docs.first;
        final List students =
            (classDoc.data()['studentsIds'] as List?) ?? [];

        if (!students.contains(uid)) {
          students.add(uid);
          await classDoc.reference.update({'studentsIds': students});
          print('Student added to class $className');
        } else {
          print('Student already in class $className');
        }
      } else {
        print('No class found with name $className');
      }
    }

    // 4. Return the user model
    return UserModel(
      id: uid,
      name: name,
      email: email,
      role: role,
      className: className,
    );
  } catch (e) {
    print('Error during registration: $e');
    rethrow;
  }
}


  Future<void> signOut() async {
    await _auth.signOut();
  }
}
