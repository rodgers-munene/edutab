import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:edutab/providers/auth_provider.dart';

class StudentDrawer extends StatefulWidget {
  const StudentDrawer({super.key});

  @override
  State<StudentDrawer> createState() => _StudentDrawerState();
}

class _StudentDrawerState extends State<StudentDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final details = authProvider.currentUser;

    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SafeArea(
        child: Column(
          children: [
            // Top section (header + items)
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundColor: Theme.of(context).highlightColor,
                          child: Icon(
                            Icons.person,
                            size: 30,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          details?.name ?? "Loading..",
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          details?.email ?? "",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          details?.className ?? "",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(color: Colors.grey.shade400),

                  // drawer items
                  ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text("Notifications"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text("Settings"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.help),
                    title: const Text("Help"),
                    onTap: () {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.info),
                    title: const Text("About"),
                    onTap: () {},
                  ),
                ],
              ),
            ),

            // Bottom section (divider + logout)
            Column(
              children: [
                Divider(color: Colors.grey.shade400),
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title: const Text("Logout"),
                  onTap: () {
                    authProvider.signOut();
                  },
                ),
                SizedBox(height: 7),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
