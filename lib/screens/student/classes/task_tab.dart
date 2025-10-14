import 'package:edutab/widgets/student-classes/feed_test_notification.dart';
import 'package:flutter/material.dart';

class TaskTab extends StatelessWidget {
  const TaskTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(12),
        child: Column(
          children: [
            FeedTestNotification(testTitle: "Mid Term Task 1 DSA", teacher: "Ms Nazneen Ansari",),
            const SizedBox(height: 40,),
            FeedTestNotification(testTitle: "Mid Term Task 1 OS", teacher: "Ms Nazneen Ansari", status: "Completed",)
          ],
        ),
      ),
    );
  }
}