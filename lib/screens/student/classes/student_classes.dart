import 'package:flutter/material.dart';

class StudentClasses extends StatelessWidget {
  const StudentClasses({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("My Classes")),
    body: const Center(child: Text("Classes List")),
  );
}