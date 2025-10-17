import 'package:edutab/screens/student/classes/clips_tab.dart';
import 'package:edutab/screens/student/classes/feed_tab.dart';
import 'package:edutab/screens/student/classes/material_tab.dart';
import 'package:edutab/screens/student/classes/task_tab.dart';
import 'package:flutter/material.dart';

class StudentClasses extends StatelessWidget {
  const StudentClasses({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          toolbarHeight: 0,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(80), 
            child: Container(
              color: Colors.white,
              child: const TabBar(
                
                tabs: [
                  _CustomTab(icon: Icons.dynamic_feed, text: "Feed"),
                  _CustomTab(icon: Icons.task, text: "Task"),
                  _CustomTab(icon: Icons.menu_book, text: "Material"),
                  // _CustomTab(icon: Icons.quiz, text: "Tests"),
                  _CustomTab(icon: Icons.play_circle_fill, text: "Clips"),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            FeedTab(),
            TaskTab(),
            MaterialTab(),
            // Center(child: Text("Tests Page")),
            ClipsTab(),
          ],
        ),
      ),
    );
  }
}

// Custom Tab widget with circular grey background icons
class _CustomTab extends StatelessWidget {
  final IconData icon;
  final String text;

  const _CustomTab({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Tab(
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.grey.shade200, // greyish background
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 24, color: Colors.black),
      ),
      child: Text(text, style: const TextStyle(fontSize: 12)),
    );
  }
}
