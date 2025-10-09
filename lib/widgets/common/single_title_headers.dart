import 'package:flutter/material.dart';

class SingleTitleHeaders extends StatelessWidget {
  final String title;
  const SingleTitleHeaders({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Text(
       title,
       style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold
       ),
      ),
    );
  }
}
