import 'package:edutab/models/class_model.dart';
import 'package:edutab/widgets/common/single_title_headers.dart';
import 'package:edutab/widgets/dashboard/student_info.dart';
import 'package:edutab/widgets/dashboard/student_navigation_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:edutab/providers/auth_provider.dart';
import 'package:edutab/providers/class_provider.dart';
import 'package:edutab/providers/task_provider.dart';
import 'package:edutab/providers/video_provider.dart';
import 'package:edutab/models/user_model.dart';
import 'package:intl/intl.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({super.key});

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // final authProvider = context.read<AuthProvider>();
      // final classProvider = context.read<ClassProvider>();

      // Listen to tasks and videos
      context.read<TaskProvider>().listenToTasks();
      context.read<VideoProvider>().listenToVideos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final classProvider = context.watch<ClassProvider>();
    final taskProvider = context.watch<TaskProvider>();
    final videoProvider = context.watch<VideoProvider>();

    final UserModel? user = authProvider.currentUser;

    // If user not loaded yet, show loading state
    if (user == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Get class info (might be null if student hasn't been assigned to a class)
    final ClassModel? studentClassInfo = classProvider.currentClass;

    // Get real pending tasks (limit to 3 for dashboard)
    final pendingTasks = taskProvider.pendingTasks.take(3).toList();

    // Get recent videos (limit to 3 for dashboard)
    final recentVideos = videoProvider.videos.take(3).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- 1. Header Section: Welcome & Student Info ---
            StudentInfo(userName: user.name, className: user.className,),

            const SizedBox(height: 40),

            // --- 2. Navigation Grid Section ---
            SingleTitleHeaders(title: "Quick Access", showSeeAll: false),
            const SizedBox(height: 15),
            const StudentNavigationGrid(),
            const SizedBox(height: 30),

            // --- 3. Upcoming Class Section (only if class exists) ---
            if (studentClassInfo != null) ...[
              SingleTitleHeaders(title: "Upcoming Class", showSeeAll: false),
              const SizedBox(height: 15),
              _buildUpcomingClassCard(
               "English",
                studentClassInfo.id,
              ),
              const SizedBox(height: 30),
            ],

            // --- 4. Videos for You Section ---
            SingleTitleHeaders(
              title: "Videos for You",
              
            ),
            const SizedBox(height: 15),
            _buildVideosForYouSection(
              context,
              recentVideos,
              videoProvider.isLoading,
            ),
            const SizedBox(height: 30),

            // --- 5. Pending Tasks Section ---
            SingleTitleHeaders(
              title: "Pending Tasks",
              
            ),
            const SizedBox(height: 15),
            _buildPendingTasksSection(
              context,
              pendingTasks,
              taskProvider.isLoading,
            ),
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
                  "Your Class:",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  className,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.access_time, color: Colors.white, size: 16),
                    SizedBox(width: 5),
                    Text(
                      "Next class in 15 min",
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
              Navigator.pushNamed(context, '/classes');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildVideosForYouSection(
    BuildContext context,
    List<dynamic> videos,
    bool isLoading,
  ) {
    if (isLoading) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (videos.isEmpty) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.video_library_outlined,
                size: 50,
                color: Colors.grey[400],
              ),
              const SizedBox(height: 10),
              Text(
                'No videos available yet',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      );
    }

    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final video = videos[index];
          return _VideoCard(
            title: video.title,
            thumbnailUrl: video.thumbnailUrl,
            duration: video.formattedDuration,
            onTap: () {
              context.read<VideoProvider>().incrementViews(video.id);
              // Open video player or navigate to video details
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Playing: ${video.title}')),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildPendingTasksSection(
    BuildContext context,
    List<dynamic> tasks,
    bool isLoading,
  ) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (tasks.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.green[50],
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.green[200]!),
        ),
        child: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green[600], size: 40),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'All caught up!',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'You have no pending tasks',
                    style: TextStyle(color: Colors.green[700]),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Column(
      children: tasks.map((task) {
        final isOverdue =
            !task.isCompleted && task.dueDate.isBefore(DateTime.now());
        final dueDate = DateFormat('MMM dd, h:mm a').format(task.dueDate);

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          elevation: 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: isOverdue
                ? BorderSide(color: Colors.red[300]!, width: 1)
                : BorderSide.none,
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isOverdue ? Colors.red[50] : Colors.blue.shade50,
              child: Icon(
                isOverdue ? Icons.warning_amber : Icons.assignment,
                color: isOverdue ? Colors.red[700] : Colors.blue.shade700,
              ),
            ),
            title: Text(
              task.title,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text(
              "${task.subject} • Due $dueDate",
              style: TextStyle(color: isOverdue ? Colors.red[700] : null),
            ),
            trailing: Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                if (value != null) {
                  context.read<TaskProvider>().toggleTaskCompletion(
                    task.id,
                    value,
                  );
                }
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/tasks');
            },
          ),
        );
      }).toList(),
    );
  }
}

// Custom Video Card Widget
class _VideoCard extends StatelessWidget {
  final String title;
  final String thumbnailUrl;
  final String duration;
  final VoidCallback onTap;

  const _VideoCard({
    required this.title,
    required this.thumbnailUrl,
    required this.duration,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        margin: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Image.network(
                    thumbnailUrl,
                    height: 140,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 140,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(
                            Icons.video_library,
                            size: 50,
                            color: Colors.grey,
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        duration,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.all(12),
                color: Colors.white,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
