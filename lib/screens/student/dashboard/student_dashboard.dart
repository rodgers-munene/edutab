import 'package:edutab/models/class_model.dart';
import 'package:edutab/widgets/common/single_title_headers.dart';
import 'package:edutab/widgets/common/youtube_launcher.dart';
import 'package:edutab/widgets/dashboard/student_info.dart';
import 'package:edutab/widgets/dashboard/student_navigation_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:edutab/providers/auth_provider.dart';
import 'package:edutab/providers/class_provider.dart';
import 'package:edutab/models/user_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DashboardTaskItem {
  final String title;
  final String subject;
  final String dueDate;
  final VoidCallback onTap;

  DashboardTaskItem({
    required this.title,
    required this.subject,
    required this.dueDate,
    required this.onTap,
  });
}

// --- The Main Student Dashboard Widget ---
class StudentDashboard extends StatelessWidget {
  const StudentDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final classProvider = context.watch<ClassProvider>();
    final UserModel? user = authProvider.currentUser;
    final ClassModel? studentClassInfo = classProvider.currentClass;

    // If user or class data not loaded yet, show loading state
    if (user == null || studentClassInfo == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final className = studentClassInfo.className;
    final String currentClassId = studentClassInfo.id;

    // --- Placeholder Data for Videos and Tasks ---
    final List<Map<String, dynamic>> recentVideos = [
      {
        "title": "Introduction to Algorithms",
        "videoId": "1gDhl4leEzA",
        "thumbnailUrl": "https://img.youtube.com/vi/1gDhl4leEzA/hqdefault.jpg",
        "duration": "15:30",
      },
      {
        "title": "JavaScript for Beginners",
        "videoId": "PkZNo7MFNFg",
        "thumbnailUrl": "https://img.youtube.com/vi/PkZNo7MFNFg/hqdefault.jpg",
        "duration": "22:10",
      },
      {
        "title": "Python Tutorial for Beginners",
        "videoId": "_uQrJ0TkZlc",
        "thumbnailUrl": "https://img.youtube.com/vi/_uQrJ0TkZlc/hqdefault.jpg",
        "duration": "45:00",
      },
    ];

    final List<DashboardTaskItem> pendingTasks = [
      DashboardTaskItem(
        title: "Complete Math Homework",
        subject: "Mathematics",
        dueDate: "Today, 5 PM",
        onTap: () => print("View Math Homework"),
      ),
      DashboardTaskItem(
        title: "Prepare for Science Quiz",
        subject: "Science",
        dueDate: "Tomorrow, 9 AM",
        onTap: () => print("View Science Quiz"),
      ),
      DashboardTaskItem(
        title: "Read Chapter 3 - Literature",
        subject: "Literature",
        dueDate: "Oct 28",
        onTap: () => print("View Literature Task"),
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.white, // Overall background
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. Header Section: Welcome & Student Info ---
            StudentInfo(userName: user.name),

            const SizedBox(height: 40),

            // --- 2. Navigation Grid Section ---
            SingleTitleHeaders(title: "Quick Access", showSeeAll: false),
            const SizedBox(height: 15),
            StudentNavigationGrid(),
            const SizedBox(height: 30),

            // --- 3. Upcoming Class Section ---
            SingleTitleHeaders(title: "Upcoming Class"),
            const SizedBox(height: 15),
            _buildUpcomingClassCard(className, currentClassId),
            const SizedBox(height: 30),

            // --- 4. Videos for You Section ---
            SingleTitleHeaders(title: "Videos for You"),
            const SizedBox(height: 15),
            _buildVideosForYouSection(recentVideos),
            const SizedBox(height: 30),

            // --- 5. Pending Tasks Section ---
            SingleTitleHeaders(title: "Pending Tasks"),
            const SizedBox(height: 15),
            _buildPendingTasksSection(pendingTasks),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingClassCard(String className, String classId) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue.shade700, Colors.blue.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.shade200.withOpacity(0.5),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.laptop_chromebook, color: Colors.white, size: 40),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Next Class Starts In:",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  "Data Structures & Algorithms", // This should come from a schedule/provider
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      "15 min (10:00 AM - 11:00 AM)", // From schedule
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
            onPressed: () {
              // Navigate to current class details
              print("Go to $className class details");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVideosForYouSection(List<Map<String, dynamic>> videos) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return YouTubeLauncher(
            videoId: video['videoId'],
            title: video['title'],
            thumbnailUrl: video['thumbnailUrl'],
            duration: video['duration'],
          );
        },
      ),
    );
  }

  Widget _buildPendingTasksSection(List<DashboardTaskItem> tasks) {
    return Column(
      children: tasks.map((task) {
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue.shade50,
              child: Icon(Icons.assignment, color: Colors.blue.shade700),
            ),
            title: Text(
              task.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text("${task.subject} • Due ${task.dueDate}"),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 18,
              color: Colors.grey,
            ),
            onTap: task.onTap,
          ),
        );
      }).toList(),
    );
  }
}
