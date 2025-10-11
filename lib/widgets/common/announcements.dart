import 'package:carousel_slider/carousel_slider.dart';
import 'package:edutab/screens/shared/announcement_screen.dart';
import 'package:flutter/material.dart';

class Announcements extends StatefulWidget {
  const Announcements({super.key});

  @override
  State<Announcements> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

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

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CarouselSlider(
          carouselController: _controller,
          items: announcements.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 10,
                  ),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        item['title'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF011032),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Text(
                          item['message'],
                          style: TextStyle(
                            color: Colors.grey.shade800,
                            height: 1.4,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item['date'],
                            style: TextStyle(
                              fontSize: 12,
                              fontStyle: FontStyle.italic,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => AnnouncementScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF011032),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                            ),
                            child: const Text("View all"),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }).toList(),
          options: CarouselOptions(
            height: 250,
            viewportFraction: 0.95,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 5),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            enlargeCenterPage: true,
            enlargeFactor: 0.3,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),

        // 🟣 Indicator Dots
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: announcements.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: _currentIndex == entry.key ? 16 : 8,
                height: 8,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: _currentIndex == entry.key
                      ? const Color(0xFF011032)
                      : Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
