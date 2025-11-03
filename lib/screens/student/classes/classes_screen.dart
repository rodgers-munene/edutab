import 'package:edutab/providers/class_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math';

class ClassesScreen extends StatefulWidget {
  const ClassesScreen({super.key});

  @override
  State<ClassesScreen> createState() => _ClassesScreenState();
}

class _ClassesScreenState extends State<ClassesScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Load the student's class and subjects
      // You'll need to pass the student's className from auth/user data
      final className = 'Grade 4'; // Get this from current user data
      context.read<ClassProvider>().loadClass(className);
      context.read<ClassProvider>().loadSubjects(className);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // --- CHANGED ---
        // "My Dashboard" is a more common and professional title
        title: const Text('My Classes'),
        elevation: 0,
      ),
      body: Consumer<ClassProvider>(
        builder: (context, provider, child) {
          if (provider.currentClass == null || provider.subjects.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          final classInfo = provider.currentClass!;
          final subjects = provider.subjects;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- NEW ---
              // A dedicated, cleaner header widget
              _ClassHeader(
                className: classInfo.className,
                subjectCount: subjects.length,
              ),
              const SizedBox(height: 8), // Reduced spacing
              // Subjects List
              Expanded(
                child: ListView.builder(
                  // --- CHANGED ---
                  // Added vertical padding for better scrolling and whitespace
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                  itemCount: subjects.length,
                  itemBuilder: (context, index) {
                    return _SubjectCard(
                      subject: subjects[index],
                      index: index,
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// --- NEW WIDGET ---
// Extracted the header for cleanliness and reusability
class _ClassHeader extends StatelessWidget {
  final String className;
  final int subjectCount;

  const _ClassHeader({
    required this.className,
    required this.subjectCount,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                className,
                style: textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$subjectCount Subjects',
                style: textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SubjectCard extends StatelessWidget {
  final String subject;
  final int index;

  const _SubjectCard({
    required this.subject,
    required this.index,
  });

  // Generate dummy data for each subject
  Map<String, dynamic> _getSubjectData() {
    // Used index in seed to ensure data is different for each card
    final random = Random(subject.hashCode + index);
    final pendingTasks = random.nextInt(5); // Can be 0
    final completedTasks = random.nextInt(10) + 5;
    final upcomingTests = random.nextInt(3);
    final progress = (random.nextInt(40) + 60).toDouble();

    return {
      'pendingTasks': pendingTasks,
      'completedTasks': completedTasks,
      'upcomingTests': upcomingTests,
      'progress': progress,
    };
  }

  // --- REMOVED ---
  // Removed the _getSubjectColor() function.
  // We will now use Theme.of(context).primaryColor

  IconData _getSubjectIcon() {
    // --- NOTE ---
    // This is great. Using lowercase ensures better matching.
    switch (subject.toLowerCase()) {
      case 'math':
      case 'mathematics':
        return Icons.calculate;
      case 'english':
        return Icons.menu_book;
      case 'kiswahili':
        return Icons.language;
      case 'science':
        return Icons.science;
      case 'social studies':
        return Icons.public;
      default:
        return Icons.auto_stories_outlined; // Changed to a more specific default
    }
  }

  @override
  Widget build(BuildContext context) {
    // --- CHANGED ---
    // The main color is now driven by your app's theme for consistency
    final Color color = Theme.of(context).primaryColor;
    final data = _getSubjectData();
    final hasPendingTasks = data['pendingTasks'] > 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.05), // Softer shadow
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: () {
          // Navigate to subject details
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  // Subject Icon
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      // --- CHANGED ---
                      color: color.withOpacity(0.1), // Uses theme color
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      _getSubjectIcon(),
                      // --- CHANGED ---
                      color: color, // Uses theme color
                      size: 30,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Subject Name & Progress
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subject,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: LinearProgressIndicator(
                                  value: data['progress'] / 100,
                                  // --- CHANGED ---
                                  backgroundColor: color.withOpacity(0.2),
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(color),
                                  minHeight: 8,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '${data['progress'].toInt()}%',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                // --- CHANGED ---
                                color: color, // Uses theme color
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Stats Row
              Row(
                children: [
                  Expanded(
                    child: _StatChip(
                      icon: Icons.assignment_outlined,
                      label: 'Pending',
                      value: '${data['pendingTasks']}',
                      // --- CHANGED ---
                      // Refined colors for better visual hierarchy
                      color: Colors.orange[700]!,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _StatChip(
                      icon: Icons.check_circle_outline,
                      label: 'Completed',
                      value: '${data['completedTasks']}',
                      // --- CHANGED ---
                      color: Colors.green[700]!,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _StatChip(
                      icon: Icons.quiz_outlined,
                      label: 'Tests',
                      value: '${data['upcomingTests']}',
                      // --- CHANGED ---
                      color: Colors.blue[700]!,
                    ),
                  ),
                ],
              ),
              // Action Buttons
              // --- CHANGED ---
              // Simplified the condition
              if (hasPendingTasks) ...[
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    // --- CHANGED ---
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.warning_amber_rounded,
                        size: 16,
                        // --- CHANGED ---
                        color: Colors.orange[800], // Matched stat chip
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'You have ${data['pendingTasks']} pending task${data['pendingTasks'] > 1 ? 's' : ''}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          // --- CHANGED ---
                          color: Colors.orange[800], // Matched stat chip
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              // --- CHANGED ---
              fontSize: 11, // Slightly larger for readability
              color: Colors.grey[700], // A bit darker
            ),
          ),
        ],
      ),
    );
  }
}