import 'package:edutab/providers/auth_provider.dart';
// import 'package:edutab/widgets/common/profile_tiles.dart'; // No longer needed
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use Consumer for safe access to user and to rebuild if auth state changes
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final user = authProvider.currentUser;

          // Handle null user case gracefully
          if (user == null) {
            return const Center(
              child: Text('User not logged in.'),
            );
          }

          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16), // Consistent padding
              child: Column(
                children: [
                  // --- NEW: Custom Profile Header Widget ---
                  _ProfileHeader(
                    name: user.name,
                    email: user.email,
                    avatarAsset: "assets/images/owl.png", // Pass in asset
                  ),
                  const SizedBox(height: 30),

                  // --- NEW: List of LMS Profile Tiles ---
                  Column(
                    children: [
                      // --- Academic Group ---
                      _ProfileMenuTile(
                        title: 'Edit Profile',
                        icon: Icons.person_outline,
                        onTap: () {
                          // Navigate to Edit Profile Screen
                        },
                      ),
                      _ProfileMenuTile(
                        title: 'My Grades',
                        icon: Icons.bar_chart_outlined,
                        onTap: () {
                          // Navigate to Grades Screen
                        },
                      ),
                      _ProfileMenuTile(
                        title: 'My Achievements',
                        icon: Icons.emoji_events_outlined,
                        onTap: () {
                          // Navigate to Achievements Screen
                        },
                      ),
                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 10),

                      // --- Settings Group ---
                      _ProfileMenuTile(
                        title: 'Notification Settings',
                        icon: Icons.notifications_none_outlined,
                        onTap: () {
                          // Navigate to Notification Settings
                        },
                      ),
                      _ProfileMenuTile(
                        title: 'Appearance',
                        icon: Icons.palette_outlined,
                        onTap: () {
                          // Show theme (light/dark) selector
                        },
                      ),
                      
                      const SizedBox(height: 10),
                      const Divider(),
                      const SizedBox(height: 10),

                      // --- Support Group ---
                      _ProfileMenuTile(
                        title: 'Help & Support',
                        icon: Icons.help_outline,
                        onTap: () {
                          // Navigate to Help Center
                        },
                      ),
                      _ProfileMenuTile(
                        title: 'About ElimuTab',
                        icon: Icons.info_outline,
                        onTap: () {
                          // Show About Dialog
                        },
                      ),

                      const SizedBox(height: 20),

                      // --- Logout Button ---
                      _ProfileMenuTile(
                        title: 'Logout',
                        icon: Icons.logout,
                        // Use theme's error color for emphasis
                        color: Theme.of(context).colorScheme.error,
                        trailing: false, // No chevron for logout
                        onTap: () {
                          // Show confirmation dialog, then logout
                          authProvider.signOut();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

/// --- NEW WIDGET: Reusable Profile Header ---
/// Consolidates the header logic into a clean, centered widget.
class _ProfileHeader extends StatelessWidget {
  final String name;
  final String email;
  final String avatarAsset;

  const _ProfileHeader({
    required this.name,
    required this.email,
    required this.avatarAsset,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        // Use Stack to place the edit icon on the avatar
        Stack(
          children: [
            CircleAvatar(
              radius: 60,
              // Use backgroundImage for proper clipping in CircleAvatar
              backgroundImage: AssetImage(avatarAsset),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colorScheme.primary, // Use theme color
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 2,
                    color: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
                child: IconButton(
                  icon: const Icon(Icons.camera_alt_outlined, color: Colors.white, size: 20),
                  onPressed: () {
                    // Handle change profile picture
                  },
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Use standard text themes
        Text(
          name,
          style: textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          email,
          style: textTheme.bodyMedium?.copyWith(color: Colors.blueGrey),
        ),
      ],
    );
  }
}

/// --- NEW WIDGET: Reusable Profile Menu Tile ---
/// A standardized ListTile for your profile menu.
class _ProfileMenuTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color; // Optional color override
  final bool trailing; // To show/hide the chevron

  const _ProfileMenuTile({
    required this.title,
    required this.icon,
    required this.onTap,
    this.color,
    this.trailing = true,
  });

  @override
  Widget build(BuildContext context) {
    final tileColor = color ?? Theme.of(context).textTheme.bodyLarge?.color;
    
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: tileColor),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
          color: tileColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: trailing
          ? Icon(Icons.chevron_right, color: Colors.grey[400])
          : null,
    );
  }
}