import 'package:flutter/material.dart';

class ScheduleList extends StatelessWidget {
  const ScheduleList({super.key});

  @override
  Widget build(BuildContext context) {
    final lessons = [
      {
        "time": "08:00 am",
        "title": "Data Analysis and Algorithms Live Class",
        "link": "googlemeet.eduhoot.com",
        "teacher": "Ms Nazneen Ansari",
        "timeRange": "8:30 am - 9:30 am",
        "color": Colors.cyanAccent,
      },
      {
        "time": "09:00 am",
        "title": "Web Development Live Class",
        "link": "googlemeet.eduhoot.com",
        "teacher": "Mrs Kristin Watson",
        "timeRange": "9:30 am - 10:30 am",
        "color": Colors.orangeAccent,
      },
      {
        "time": "10:00 am",
        "title": "Database Management Live Class",
        "link": "googlemeet.eduhoot.com",
        "teacher": "Mr Robert Fox",
        "timeRange": "10:30 am - 11:30 am",
        "color": Colors.redAccent,
      },
      {
        "time": "12:00 pm",
        "title": "Web Development: Task submission due today",
        "link": "googlemeet.eduhoot.com",
        "teacher": "Ms Natalie Brown",
        "timeRange": "12:00 pm - 12:30 pm",
        "color": Colors.purpleAccent,
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: lessons.map((lesson) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 8),
                child: Text(
                  lesson["time"] as String,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.black54,
                  ),
                ),
              ),
              LessonCard(
                title: lesson["title"] as String,
                link: lesson["link"] as String,
                teacher: lesson["teacher"] as String,
                timeRange: lesson["timeRange"] as String,
                backgroundColor: lesson["color"] as Color,
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class LessonCard extends StatelessWidget {
  final String title;
  final String link;
  final String teacher;
  final String timeRange;
  final Color backgroundColor;

  const LessonCard({
    super.key,
    required this.title,
    required this.link,
    required this.teacher,
    required this.timeRange,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor.withOpacity(0.4),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              const Text(
                "Link: ",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              Expanded(
                child: Text(
                  link,
                  style: TextStyle(
                    color: Colors.blue.shade900,
                    decoration: TextDecoration.underline,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            teacher,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
          const SizedBox(height: 4),
          Text(
            timeRange,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
