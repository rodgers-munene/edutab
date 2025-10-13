import 'package:flutter/material.dart';

class TeacherPost extends StatelessWidget {
  const TeacherPost({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
            offset: Offset(0, 3)
          )
        ]
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child: Image.asset(
                      "assets/images/teacher_profile.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ms Nazneen Ansari",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Posted on 29th September",
                        style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                      ),
                    ],
                  ),
                ],
              ),

              Container(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  "Teacher",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            "Hello Students, \nThe Data Structures and Algorithms lecture for today has been cancelled, we will catch up next week, until then I request you to read the material I have posted. \nHave a good week!",
          ),
          Row(
            children: [
              Text("2", style: TextStyle(fontSize: 18, color: Colors.blueGrey)),
              const SizedBox(width: 3),
              Icon(Icons.message, size: 18, color: Colors.blueGrey,),
            ],
          ),
          Divider(),
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Row(
              children: [
                Expanded(child: Text("Comment")),
                IconButton(onPressed: () {}, icon: Icon(Icons.send)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
