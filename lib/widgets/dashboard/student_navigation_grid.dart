import 'package:edutab/screens/student/classes/student_classes.dart';
import 'package:edutab/screens/student/materials/student_materials.dart';
import 'package:edutab/screens/student/progress/student_progress.dart';
import 'package:edutab/screens/student/tasks/student_tasks.dart';
import 'package:edutab/screens/student/videos/student_videos.dart';
import 'package:flutter/material.dart';

class DashboardGridItem {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  DashboardGridItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });
}


class StudentNavigationGrid extends StatelessWidget {
  const StudentNavigationGrid({super.key});

  @override
  Widget build(BuildContext context) {

    final List<DashboardGridItem> gridItems = [
      DashboardGridItem(
        title: "My Classes",
        icon: Icons.school_outlined,
        color: Colors.blue.shade100,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const StudentClasses()),
        ),
      ),
      DashboardGridItem(
        title: "Tasks",
        icon: Icons.assignment_outlined,
        color: Colors.green.shade100,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const StudentTasks()),
        ),
      ),
      DashboardGridItem(
        title: "Materials",
        icon: Icons.folder_open_outlined,
        color: Colors.orange.shade100,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const StudentMaterials()),
        ),
      ),
      DashboardGridItem(
        title: "Videos",
        icon: Icons.play_circle_outline,
        color: Colors.purple.shade100,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const StudentVideos()),
        ),
      ),
      DashboardGridItem(
        title: "My Progress",
        icon: Icons.analytics_outlined,
        color: Colors.red.shade100,
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const StudentProgress()),
        ),
      ),
    ];
    return _buildNavigationGrid(gridItems);
  }

   Widget _buildNavigationGrid(List<DashboardGridItem> items) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, 
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 1.0, 
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return InkWell(
          onTap: item.onTap,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            decoration: BoxDecoration(
              color: item.color,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: item.color.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  size: 40,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 10),
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}