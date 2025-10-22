import 'package:flutter/material.dart';

class SingleTitleHeaders extends StatelessWidget {
  final String title;
  final bool showSeeAll;
  VoidCallback? onSeeAllTap;
  SingleTitleHeaders({super.key, required this.title, this.showSeeAll = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        if (showSeeAll)
          TextButton(
            onPressed: onSeeAllTap ?? () => print("See All $title"),
            child: const Text(
              "See All",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
            ),
          ),
      ],
    );
  }
}
