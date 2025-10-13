import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedMaterialNotification extends StatelessWidget {
  const FeedMaterialNotification({super.key});

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
            children: [
              CircleAvatar(child: Icon(FontAwesomeIcons.book)),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "New Material",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Posted on 30th September",
                    style: TextStyle(fontSize: 12, color: Colors.blueGrey),
                  ),
                ],
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
                Image.asset("assets/images/material_image.png", fit: BoxFit.cover),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Chapter 1", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                      Text("Ms Nazneen Ansari", style: TextStyle(color: Colors.blueGrey, fontSize: 14),),
                      Text("30th Oct 2025", style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
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
