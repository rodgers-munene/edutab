import 'package:edutab/providers/class_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:edutab/providers/auth_provider.dart';

class StudentDrawer extends StatelessWidget {
  const StudentDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = [
      "assets/images/dsa.png", 
      "assets/images/database.png",
      "assets/images/oop.png",
      "assets/images/os.png",
      "assets/images/web.png"
      ];
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final classProvider = Provider.of<ClassProvider>(context, listen: false);
    final studentSubjects = classProvider.subjects;

    final width = MediaQuery.of(context).size.width;

    return Drawer(
      width: width * .85,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SafeArea(
        child: Column(
          children: [
            // ===== Drawer Header =====
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.school,
                              size: 29,
                              color: Colors.blue,
                            ),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Divider(),

            // ===== Class Items =====
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Classes",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                  ),
                ),
                const SizedBox(height: 15),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    final subject = studentSubjects[index];
                    return _buildClassItem(
                      imgPath: images[index],
                      text: subject,
                      onTap: () {},
                    );
                  },
                ),
                const Divider(color: Colors.grey),
              ],
            ),

            // ===== Drawer Items =====
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  // _buildDrawerItem(
                  //   icon: Icons.calendar_today_sharp,
                  //   text: "Timetable",
                  //   onTap: () {},
                  // ),
                  _buildDrawerItem(
                    icon: Icons.settings,
                    text: "Settings",
                    onTap: () {},
                  ),
                  _buildDrawerItem(
                    icon: Icons.help,
                    text: "Help",
                    onTap: () {},
                  ),
                  _buildDrawerItem(
                    icon: Icons.logout,
                    text: "Logout",
                    color: Colors.red,
                    onTap: () {
                      authProvider.signOut();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildDrawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    Color? color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color ?? Colors.black87),
      title: Text(
        text,
        style: TextStyle(
          color: color ?? Colors.black87,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
    );
  }

  ListTile _buildClassItem({
    required String imgPath,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: Image.asset(imgPath, height: 50, width: 50, fit: BoxFit.cover),
      ),
      title: Text(
        text,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: onTap,
    );
  }
}
