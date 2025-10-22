import 'package:flutter/material.dart';

class StudentProgress extends StatelessWidget {
  const StudentProgress({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("My Progress")),
    body: const Center(child: Text("Progress Details")),
  );
}
