import 'package:edutab/providers/auth_provider.dart';
import 'package:edutab/widgets/common/profile_tiles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final user = authProvider.currentUser;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              // profile image/ icon page
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        child: Image.asset("assets/images/owl.png"),
                      ),
                      Positioned(
                        right: 5,
                        bottom: 0,
                        child: Icon(Icons.camera_alt_outlined, color: Colors.blueAccent,),
                      ),
                    ],
                  ),
          
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Text(user!.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),),
                        const SizedBox(height: 5,),
                        Text(user.email, style: TextStyle(color: Colors.blueGrey, fontSize: 16),),
                        const SizedBox(height: 5,),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)
                            )
                          ),
                          onPressed: (){}, 
                          child: Text("Edit Profile")
                        )
          
                    ],
                  )
                ],
              ),
              const SizedBox(height: 30,),
              ProfileTiles()
            ],
          ),
        ),
      ),
    );
  }
}
