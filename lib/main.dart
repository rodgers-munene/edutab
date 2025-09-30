import 'package:edutab/core/constants/app_routes.dart';
import 'package:edutab/core/theme/app_theme.dart';
import 'package:edutab/navigation/app_router.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'providers/auth_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AuthProvider())],
      child: MaterialApp(
        title: 'Edu Tab',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        // initial route
        initialRoute: AppRoutes.login,
        // custom router
        onGenerateRoute: AppRouter.generateRoute,
      ),
    );
  }
}
