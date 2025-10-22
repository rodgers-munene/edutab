import 'package:flutter/material.dart';

class StudentVideos extends StatelessWidget {
  const StudentVideos({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Video Library")),
    body: const Center(child: Text("Videos List")),
  );
}