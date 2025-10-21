import 'package:edutab/navigation/bottom_nav_bar.dart';
import 'package:edutab/navigation/splash_screen.dart';
import 'package:edutab/providers/class_provider.dart';
import 'package:edutab/screens/auth/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:edutab/providers/auth_provider.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _startedLoadingProfile = false;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final authProvider = Provider.of<AuthProvider>(context);
        final classProvider = Provider.of<ClassProvider>(context);
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }

        if (!snapshot.hasData) {
          _startedLoadingProfile = false;
          return const LoginScreen();
        }

        // if user is signed in but profile not loaded, trigger load once
        if (authProvider.currentUser == null) {
          if (!_startedLoadingProfile) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              if (!mounted) return;
              _startedLoadingProfile = true;
              await authProvider.loadUserData();
              if (authProvider.currentUser != null) {
                classProvider.loadSubjects(authProvider.currentUser!.className);
              }
            });
          }
          return const SplashScreen();
        }

        return const BottomNavBar();
      },
    );
  }
}
