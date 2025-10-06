import 'package:flutter/material.dart';

class StudentDetailsHeader extends StatelessWidget {
  final String userName;
  final String userClass;

  const StudentDetailsHeader({
    super.key,
    required this.userName,
    required this.userClass,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        // border: BoxBorder.all(),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300.withValues(alpha: 0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          // profile picture
          CircleAvatar(
            radius: 45,
            backgroundColor: Theme.of(context).highlightColor,
            child: Icon(
              Icons.person,
              size: 45,
              color: Theme.of(context).primaryColor,
            ),
          ),

          const SizedBox(width: 20),
          // student details
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Text(
                "$userClass | Roll No. 1",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
