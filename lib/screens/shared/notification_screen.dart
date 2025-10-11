import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  // --- Dummy notification data ---
  final List<Map<String, String>> notifications = const [
    {
      "title": "New Assignment Uploaded",
      "message": "Your Mathematics teacher uploaded a new assignment on Algebra.",
      "time": "2 hours ago",
      "icon": "assignment"
    },
    {
      "title": "Announcement from Admin",
      "message": "School portal maintenance scheduled for Friday at 9 PM.",
      "time": "5 hours ago",
      "icon": "announcement"
    },
    {
      "title": "Grade Released",
      "message": "Your Web Development assignment grade has been posted.",
      "time": "1 day ago",
      "icon": "grade"
    },
    {
      "title": "New Video Lesson",
      "message": "Watch the new video lesson on 'Database Normalization'.",
      "time": "2 days ago",
      "icon": "video"
    },
    {
      "title": "Task Reminder",
      "message": "Don’t forget to submit your English essay by tomorrow.",
      "time": "3 days ago",
      "icon": "reminder"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return _buildNotificationCard(notif);
        },
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, String> notif) {
    IconData iconData;
    switch (notif["icon"]) {
      case "assignment":
        iconData = Icons.assignment;
        break;
      case "announcement":
        iconData = Icons.campaign;
        break;
      case "grade":
        iconData = Icons.grade;
        break;
      case "video":
        iconData = Icons.play_circle_fill;
        break;
      case "reminder":
        iconData = Icons.alarm;
        break;
      default:
        iconData = Icons.notifications;
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              shape: BoxShape.circle,
            ),
            child: Icon(
              iconData,
              color: Colors.blue,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notif["title"] ?? "",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  notif["message"] ?? "",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  notif["time"] ?? "",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
