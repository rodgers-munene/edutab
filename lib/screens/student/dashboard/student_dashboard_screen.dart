import 'package:edutab/providers/auth_provider.dart';
import 'package:edutab/providers/class_provider.dart';
import 'package:edutab/widgets/common/announcements.dart';
import 'package:edutab/widgets/common/single_title_headers.dart';
import 'package:edutab/widgets/dashboard/pending_tasks.dart';
import 'package:edutab/widgets/dashboard/student_info.dart';
import 'package:edutab/widgets/dashboard/watched_videos.dart';
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


  final List<Map<String, dynamic>> homeworks = [
    {'subject': 'Math', 'submitted': true, 'dueDate': DateTime(2025, 10, 10)},
    {
      'subject': 'English Essay',
      'submitted': false,
      'dueDate': DateTime(2025, 10, 13),
    },
    {
      'subject': 'Science Project',
      'submitted': false,
      'dueDate': DateTime(2025, 10, 15),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.currentUser;
    
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // student info and stats
            StudentInfo(userName: user!.name),

            const SizedBox(height: 40),
            // announcements
            SingleTitleHeaders(title: "Announcements"),
            Announcements(),

            const SizedBox(height: 40),
            // pending tasks
            SingleTitleHeaders(title: "Pending Tasks"),
            const SizedBox(height: 10),
            PendingTasks(),

            const SizedBox(height: 40),
            // watched videos
            SingleTitleHeaders(title: "Continue watching"),
            const SizedBox(height: 10),
            WatchedVideos(),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
