import 'package:edutab/core/constants/app_routes.dart';
import 'package:edutab/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    // delay to show splash screen animation
    await Future.delayed(const Duration(seconds: 3));

    // get the authproviders data
    await authProvider.loadUserData();

    // check if widget is still mounted
    if (!mounted) return;

    final currentUser = authProvider.currentUser;

    // navigation based on auth state and user role
    if (currentUser == null) {
      _navigateToLogin();
    } else {
      _navigateToBottomNavbar(currentUser.role);
    }
  }

  void _navigateToLogin() {
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  void _navigateToBottomNavbar(String role) {
    
    Navigator.pushNamedAndRemoveUntil(context, AppRoutes.bottomNavBar, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Icon(
                Icons.school_outlined,
                size: 70,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 24,),
            const Text(
              "Edu Tab Cloud",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1
              ),
            ),
            const SizedBox(height: 8,),

            Text(
              "Education Management System",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.9),
                letterSpacing: 0.5
              ),
            ),
            
            const SizedBox(height: 48,),

            SizedBox(
              height: 40,
              width: 40,
              child: CircularProgressIndicator(
                strokeWidth: 3,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white.withOpacity(0.8),
                ),
              ),
            ),

            const SizedBox(height: 16,),

            Text(
              "Loading",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white.withOpacity(0.8),
              ),
            )
          ],
        )
        )
     );
  }

}
