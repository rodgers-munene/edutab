import 'package:edutab/widgets/student-classes/teacher_post.dart';
import 'package:flutter/material.dart';

class FeedTab extends StatelessWidget {
  const FeedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        // latest post from the students teachers
        TeacherPost(),
        // new test notification

        // new material notification

        // Another test notification

      ],
    );
  }
}