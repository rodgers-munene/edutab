import 'package:flutter/material.dart';

class StudentTasks extends StatelessWidget {
  const StudentTasks({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("My Tasks")),
    body: const Center(child: Text("Tasks List")),
  );
}
