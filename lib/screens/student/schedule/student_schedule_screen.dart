import 'package:edutab/widgets/schedules/schedule_list.dart';
import 'package:edutab/widgets/schedules/week_date_bar.dart';
import 'package:flutter/material.dart';

class StudentScheduleScreen extends StatelessWidget {
  const StudentScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            WeekDateBar(weekStartsMonday: true, onDateSelected: (date) => print("Selected: $date"),),
            ScheduleList()
          ],
        ),
      )
    );
  }
}