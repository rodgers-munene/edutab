import 'package:flutter/material.dart';

class StudentMaterials extends StatelessWidget {
  const StudentMaterials({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Study Materials")),
    body: const Center(child: Text("Materials List")),
  );
}
