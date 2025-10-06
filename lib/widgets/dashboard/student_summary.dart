import 'package:flutter/material.dart';

class StudentSummary extends StatelessWidget {
  const StudentSummary({super.key});

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Today's Summary", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Attendance:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                  Text("Present", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700),),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Homeworks Due:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Text("2", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700),),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Next Class:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                  Text("Math", style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.w700),),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}