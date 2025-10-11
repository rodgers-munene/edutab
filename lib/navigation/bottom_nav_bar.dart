import 'dart:io';
import 'package:edutab/providers/auth_provider.dart';
import 'package:edutab/screens/shared/notification_screen.dart';
import 'package:edutab/screens/shared/profile_screen.dart';
import 'package:edutab/screens/student/homework_view_screen.dart';
import 'package:edutab/screens/student/student_dashboard_screen.dart';
import 'package:edutab/screens/student/student_drawer.dart';
import 'package:edutab/screens/student/student_schedule_screen.dart';
import 'package:edutab/screens/teacher/homework_upload_screen.dart';
import 'package:edutab/screens/teacher/teacher_dashboard_screen.dart';
import 'package:edutab/screens/teacher/teacher_schedule_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;

  Future<bool> _onWillPop() async {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      exit(0);
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    if (authProvider.currentUser == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final Widget dashboard = authProvider.currentUser!.role == "student"
        ? StudentDashboardScreen()
        : TeacherDashboardScreen();

    final Widget homework = authProvider.currentUser!.role == "student"
        ? HomeworkViewScreen()
        : HomeworkUploadScreen();

    final Widget schedule = authProvider.currentUser!.role == "student"
        ? StudentScheduleScreen()
        : TeacherScheduleScreen();

    final List screens = [dashboard, homework, schedule, ProfileScreen()];

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (!didPop) await _onWillPop();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 1,
          title: Row(
            children: [
              const Icon(Icons.school, size: 29, color: Colors.blue),
              const SizedBox(width: 10),
              Text(
                "Edu",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                ),
              ),
              Text(
                "Tab",
                style: TextStyle(
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => NotificationsScreen()));
              },
              icon: Icon(Icons.notifications),
              iconSize: 28,
            ),
          ],
        ),
        body: screens[_selectedIndex],
        drawer: StudentDrawer(),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xFF2196F3),
          unselectedItemColor: Colors.blueGrey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() {
            _selectedIndex = index;
          }),
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.assignment),
              label: "Homework",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: "Schedule",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          ],
        ),
      ),
    );
  }
}
