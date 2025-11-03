import 'package:flutter/material.dart';

class StudentNavigationGrid extends StatelessWidget {
  const StudentNavigationGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final navItems = [
      {'icon': Icons.class_, 'label': 'Classes', 'route': '/classes'},
      {'icon': Icons.task_alt, 'label': 'Tasks', 'route': '/tasks'},
      {'icon': Icons.description, 'label': 'Materials', 'route': '/materials'},
      {'icon': Icons.play_circle, 'label': 'Videos', 'route': '/videos'},
      {'icon': Icons.show_chart, 'label': 'Progress', 'route': '/progress'},
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 1,
      ),
      itemCount: navItems.length,
      itemBuilder: (context, index) {
        final item = navItems[index];
        return _NavigationCard(
          icon: item['icon'] as IconData,
          label: item['label'] as String,
          onTap: () {
            Navigator.pushNamed(context, item['route'] as String);
          },
        );
      },
    );
  }
}

class _NavigationCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _NavigationCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 35, color: Colors.blue.shade700),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}