import 'package:edutab/widgets/student-classes/feed_material_notification.dart';
import 'package:edutab/widgets/student-classes/feed_test_notification.dart';
import 'package:edutab/widgets/student-classes/teacher_post.dart';
import 'package:flutter/material.dart';

class FeedTab extends StatelessWidget {
  const FeedTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            // latest post from the students teachers
            TeacherPost(),
            const SizedBox(height: 30,),
            // new test notification
            FeedTestNotification(testTitle: "Mid Term Task 1", teacher: "Ms Nazneen Ansari",),
            const SizedBox(height: 30,),
            // new material notification
            FeedMaterialNotification(),
            const SizedBox(height: 30,),
            // Another test notification
            FeedTestNotification(testTitle: "Mid Term Task 1", teacher: "Ms Nazneen Ansari",),
            const SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}