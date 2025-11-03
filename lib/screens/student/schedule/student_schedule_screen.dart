import 'package:flutter/material.dart';
import 'dart:math';


class TimetableEntry {
  final String subject;
  final String teacherName;
  final String startTime;
  final String endTime;
  final Color color;

  TimetableEntry({
    required this.subject,
    required this.teacherName,
    required this.startTime,
    required this.endTime,
    required this.color,
  });
}

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'];

  @override
  void initState() {
    super.initState();
    // Initialize the TabController
    _tabController = TabController(length: _days.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Colors.grey[600],
          indicatorColor: Theme.of(context).primaryColor,
          indicatorWeight: 3.0,
          tabs: _days.map((day) => Tab(text: day)).toList(),
        ),
      ),
      // TabBarView holds the content for each tab
      body: TabBarView(
        controller: _tabController,
        // We create a DailyTimetableView for each day
        children: _days.map((day) {
          // Get the hardcoded data for the specific day
          final lessons = _dummyTimetable[day] ?? [];
          return DailyTimetableView(lessons: lessons, day: day);
        }).toList(),
      ),
    );
  }
}

// --- 3. WIDGET TO DISPLAY THE LIST FOR EACH DAY ---
class DailyTimetableView extends StatelessWidget {
  final List<TimetableEntry> lessons;
  final String day;

  const DailyTimetableView({
    super.key,
    required this.lessons,
    required this.day,
  });

  @override
  Widget build(BuildContext context) {
    if (lessons.isEmpty) {
      return Center(
        child: Text(
          'No classes scheduled for this day.',
          style: TextStyle(color: Colors.grey[700], fontSize: 16),
        ),
      );
    }

    // A clean list of TimetableCards
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: lessons.length,
      itemBuilder: (context, index) {
        return TimetableCard(lesson: lessons[index]);
      },
    );
  }
}

class TimetableCard extends StatelessWidget {
  final TimetableEntry lesson;

  const TimetableCard({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.05),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- The colored vertical bar ---
            Container(
              width: 12,
              decoration: BoxDecoration(
                color: lesson.color.withOpacity(0.8),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
            ),
            // --- The lesson content ---
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      lesson.subject,
                      style: textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Time Row
                    Row(
                      children: [
                        Icon(Icons.access_time_filled,
                            size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '${lesson.startTime} - ${lesson.endTime}',
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    // Teacher Row
                    Row(
                      children: [
                        Icon(Icons.person, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          lesson.teacherName,
                          style: textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


final _dummyTimetable = {
  'Mon': [
    TimetableEntry(
        subject: 'Math',
        teacherName: 'Mr. John Doe',
        startTime: '08:00 AM',
        endTime: '09:00 AM',
        color: Colors.blue.shade300),
    TimetableEntry(
        subject: 'English',
        teacherName: 'Ms. Jane Smith',
        startTime: '09:00 AM',
        endTime: '10:00 AM',
        color: Colors.red.shade300),
    TimetableEntry(
        subject: 'Science',
        teacherName: 'Dr. R. Brown',
        startTime: '10:30 AM',
        endTime: '11:30 AM',
        color: Colors.green.shade300),
  ],
  'Tue': [
    TimetableEntry(
        subject: 'Social Studies',
        teacherName: 'Mr. A. Davis',
        startTime: '08:00 AM',
        endTime: '09:00 AM',
        color: Colors.orange.shade300),
    TimetableEntry(
        subject: 'Kiswahili',
        teacherName: 'Mrs. W. Otieno',
        startTime: '09:00 AM',
        endTime: '10:00 AM',
        color: Colors.purple.shade300),
  ],
  'Wed': [
    TimetableEntry(
        subject: 'Math',
        teacherName: 'Mr. John Doe',
        startTime: '08:00 AM',
        endTime: '09:00 AM',
        color: Colors.blue.shade300),
    TimetableEntry(
        subject: 'Science',
        teacherName: 'Dr. R. Brown',
        startTime: '10:30 AM',
        endTime: '11:30 AM',
        color: Colors.green.shade300),
  ],
  'Thu': [
    TimetableEntry(
        subject: 'English',
        teacherName: 'Ms. Jane Smith',
        startTime: '09:00 AM',
        endTime: '10:00 AM',
        color: Colors.red.shade300),
    TimetableEntry(
        subject: 'Kiswahili',
        teacherName: 'Mrs. W. Otieno',
        startTime: '10:30 AM',
        endTime: '11:30 AM',
        color: Colors.purple.shade300),
  ],
  'Fri': [
    TimetableEntry(
        subject: 'Social Studies',
        teacherName: 'Mr. A. Davis',
        startTime: '08:00 AM',
        endTime: '09:00 AM',
        color: Colors.orange.shade300),
  ],
};