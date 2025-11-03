import 'package:flutter/material.dart';

class StudentInfo extends StatelessWidget {
  final String userName;
  final String className;

  const StudentInfo({
    super.key,
    required this.userName,
    required this.className,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    // --- UPDATED ---
    // Wrapped the Column in a styled Container to create a "header card"
    return Container(
      width: double.infinity, // Ensure it spans the width
      margin: const EdgeInsets.fromLTRB(5, 12, 5, 12), // Space around the card
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 16,
      ), // Space inside the card
      decoration: BoxDecoration(
        // Subtle, on-brand background color
        color: Theme.of(context).primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          // Gentle shadow for depth
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // "Welcome Back," text
          Text(
            'Welcome,',
            style: textTheme.titleMedium?.copyWith(
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),

          // Row to display the user's name and their class
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              // User Name (Primary focus)
              Expanded(
                child: Text(
                  userName,
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              const SizedBox(width: 16), // Spacer

              // Class Name (Secondary info)
              Text(
                className,
                style: textTheme.titleMedium?.copyWith(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}