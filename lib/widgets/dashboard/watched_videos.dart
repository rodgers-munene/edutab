import 'package:flutter/material.dart';

class WatchedVideos extends StatelessWidget {
  const WatchedVideos({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> watchedVideos = [
      {
        "image": "assets/images/male_teacher.png",
        "title": "Introduction to Flutter",
        "description":
            "Learn the basics of widgets, layouts, and the Flutter framework.",
        "progress": 0.85, // 85% watched
      },
      {
        "image": "assets/images/male_teacher.png",
        "title": "Database Systems Basics",
        "description":
            "Understand SQL, data normalization, and relational databases.",
        "progress": 0.45,
      },
      {
        "image": "assets/images/male_teacher.png",
        "title": "Responsive UI Design",
        "description":
            "Design adaptive layouts that look great on any screen size.",
        "progress": 1,
      },
    ];

    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: watchedVideos.length,
        itemBuilder: (context, index) {
          final video = watchedVideos[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: VideoCard(
              imgPath: video['image'],
              title: video['title'],
              description: video['description'],
              progress: video['progress'].toDouble(),
            ),
          );
        },
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final String imgPath;
  final String title;
  final String description;
  final double progress;

  const VideoCard({
    super.key,
    required this.imgPath,
    required this.title,
    required this.description,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      width: width * 0.65,
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
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.asset(
              imgPath,
              height: 120,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 2.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      progress == 1.0
                          ? "Completed"
                          : "${(progress * 100).toStringAsFixed(0)}% watched",
                      style: TextStyle(
                        fontSize: 12,
                        color: progress == 1.0
                            ? Colors.green
                            : Colors.grey.shade600,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
                          Text("Continue"),
                          SizedBox(width: 5),
                          Icon(Icons.play_arrow, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
