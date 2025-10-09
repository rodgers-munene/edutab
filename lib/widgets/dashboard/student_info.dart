import 'package:flutter/material.dart';

class StudentInfo extends StatelessWidget {
  final String userName;

  const StudentInfo({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;

    return SizedBox(
      height: 190, 
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 22, left: 12, bottom: 12, right: 12),
            height: 150,
            decoration: const BoxDecoration(
              color: Color(0xFF011032),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(70),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(radius: 35, child: Icon(Icons.school, size: 30)),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome,",
                      style: TextStyle(
                        fontSize: 21,
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      userName,
                      style: const TextStyle(
                        fontSize: 21,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Image.asset('assets/images/plane.png'),
              ],
            ),
          ),

          // Positioned container peeking above
          Positioned(
            bottom: -20, 
            right: 0,
            child: Container(
              width: width * .9,
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white, 
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.blue.withOpacity(0.3),
                    spreadRadius: 3,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.calendar_month, color: Colors.green,),
                      Text("75%", style: TextStyle(color: Colors.green, fontSize: 23, fontWeight: FontWeight.bold),),
                      Text("Attendance", style: TextStyle(color: Colors.green, fontSize:  14, fontWeight: FontWeight.bold), )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.check_box, color: Colors.orangeAccent,),
                      Text("08", style: TextStyle(color: Colors.orangeAccent, fontSize: 23, fontWeight: FontWeight.bold),),
                      Text("Pending tasks", style: TextStyle(color: Colors.orangeAccent, fontSize:  14, fontWeight: FontWeight.bold), )
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.personal_video, color: Colors.blue,),
                      Text("02", style: TextStyle(color: Colors.blue, fontSize: 23, fontWeight: FontWeight.bold),),
                      Text("Live Lectures", style: TextStyle(color: Colors.blue, fontSize:  14, fontWeight: FontWeight.bold), )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
