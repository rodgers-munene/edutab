import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedTestNotification extends StatelessWidget {
  const FeedTestNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // header part
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(child: Icon(FontAwesomeIcons.award)),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "New Test",
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
                  "New",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ],
          ),
          
          // body part with image
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(12)
            ),
            child: Row(
              children: [
                Image.asset("assets/images/test_image.png", fit: BoxFit.cover),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.lightBlue.withOpacity(.5)
                        ),
                        child: Text("Due: 27th Oct 2025", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                      ),
                      Text("Mid Term: DSA", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                      Text("Ms Nazneen Ansari", style: TextStyle(color: Colors.blueGrey, fontSize: 14),)
                    ],
                )
                
              ],

            ),
          )
        ],
      ),
    );
  }
}
