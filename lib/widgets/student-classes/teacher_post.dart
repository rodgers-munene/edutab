import 'package:edutab/screens/student/classes/post_details_page.dart';
import 'package:flutter/material.dart';

class TeacherPost extends StatelessWidget {
  const TeacherPost({super.key});

  @override
  Widget build(BuildContext context) {
    final Color accentColor = Colors.blueAccent;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // Navigate to Post Details page
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PostDetailsPage()),
          );
        },
        splashColor: accentColor.withOpacity(0.15),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🧑‍🏫 Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundImage:
                            AssetImage("assets/images/teacher_profile.png"),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Ms. Nazneen Ansari",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            "Posted on 29th September",
                            style: TextStyle(
                                fontSize: 12, color: Colors.blueGrey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4, horizontal: 10),
                    decoration: BoxDecoration(
                      color: accentColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Teacher",
                      style: TextStyle(
                        color: accentColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // 📄 Post content
              const Text(
                "Hello Students 👋,\n\nThe Data Structures and Algorithms lecture for today has been cancelled. "
                "We will catch up next week. Until then, please go through the posted material.\n\nHave a great week!",
                style: TextStyle(
                  fontSize: 14.5,
                  height: 1.5,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 16),

              // 💬 Comments count
              Row(
                children: const [
                  Icon(Icons.message_outlined,
                      size: 18, color: Colors.blueGrey),
                  SizedBox(width: 4),
                  Text("2 comments", style: TextStyle(color: Colors.blueGrey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

