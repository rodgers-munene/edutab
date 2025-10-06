import 'package:edutab/providers/auth_provider.dart';
import 'package:edutab/widgets/dashboard/student_details_header.dart';
import 'package:edutab/widgets/dashboard/student_summary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentDashboardScreen extends StatefulWidget {
  const StudentDashboardScreen({super.key});

  @override
  State<StudentDashboardScreen> createState() => _StudentDashboardScreenState();
}

class _StudentDashboardScreenState extends State<StudentDashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.currentUser;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(        
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // student profile picture and details
                StudentDetailsHeader(
                  userName: user!.name,
                  userClass: user.className ?? "",
                ),
        
                const SizedBox(height: 40,),
                // student summary section
                StudentSummary() 
             ],
            ),
          ),
      ),
    );
  }
}
