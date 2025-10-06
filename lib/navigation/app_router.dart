import 'package:edutab/navigation/bottom_nav_bar.dart';
import 'package:edutab/navigation/splash_screen.dart';
import 'package:edutab/screens/student/student_dashboard_screen.dart';
import 'package:flutter/material.dart';
import '../core/constants/app_routes.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/role_selection_screen.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen());

      case AppRoutes.register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());

      case AppRoutes.roleSelection:
        return MaterialPageRoute(builder: (_) => RoleSelectionScreen());

      case AppRoutes.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());

      case AppRoutes.studentDashboard:
        return MaterialPageRoute(builder: (_) => StudentDashboardScreen());

      case AppRoutes.bottomNavBar:
        return MaterialPageRoute(builder: (_) => BottomNavBar());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
