import 'package:flutter/material.dart';

class AnnouncementScreen extends StatelessWidget {
  const AnnouncementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> announcements = [
      {
        "title": "Mid-Semester Exams Schedule Released",
        "message":
            "The mid-semester exams will begin on October 21st. Check the timetable on the portal for your specific exam dates.",
        "date": "2025-10-08",
      },
      {
        "title": "New Course Materials Uploaded",
        "message":
            "Lecture notes for Database Systems and Artificial Intelligence have been uploaded to the LMS. Please review them before next week’s classes.",
        "date": "2025-10-05",
      },
      {
        "title": "Class Suspension Notice",
        "message":
            "All Friday classes are suspended due to the upcoming cultural week. Normal classes resume on Monday, October 14th.",
        "date": "2025-10-03",
      },
      {
        "title": "Assignment Submission Deadline Extended",
        "message":
            "The deadline for submitting the Mobile App Development project has been extended to October 15th, 2025.",
        "date": "2025-10-02",
      },
      {
        "title": "New Discussion Forum Opened",
        "message":
            "A new discussion forum for the Software Engineering class is now open. Share ideas and questions with your classmates.",
        "date": "2025-09-29",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text("Announcements", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: announcements.length,
        itemBuilder: (context, index) {
          final announcement = announcements[index];
          return AnnouncementCard(
            title: announcement['title'],
            message: announcement['message'],
            date: announcement['date'],
          );
        },
      ),
    );
  }
}

class AnnouncementCard extends StatelessWidget {
  final String title;
  final String message;
  final String date;

  const AnnouncementCard({
    super.key,
    required this.title,
    required this.message,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top: 12, bottom: 12, left: 12, right: 20),
      padding: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 10,),
          Text(
            message,
            // style: TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10,),
          Text(date, style: TextStyle(fontSize: 12, color: Colors.blueGrey)),
        ],
      ),
    );
  }
}
