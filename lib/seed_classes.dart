import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> seedClasses() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final firestore = FirebaseFirestore.instance;
  final classesCollection = firestore.collection('classes');

  final List<Map<String, dynamic>> classes = [
    {
      "className": "Grade 1",
      "gradeLevel": "1",
      "teacherId": "",
      "studentsIds": [],
      "subjects": ["Math", "English", "Kiswahili", "CRE", "EVS"]
    },
    {
      "className": "Grade 2",
      "gradeLevel": "2",
      "teacherId": "",
      "studentsIds": [],
      "subjects": ["Math", "English", "Kiswahili", "Science", "Social Studies"]
    },
    {
      "className": "Grade 3",
      "gradeLevel": "3",
      "teacherId": "",
      "studentsIds": [],
      "subjects": ["Math", "English", "Kiswahili", "Science", "Social Studies"]
    },
    {
      "className": "Grade 4",
      "gradeLevel": "4",
      "teacherId": "",
      "studentsIds": [],
      "subjects": ["Math", "English", "Kiswahili", "Science", "Social Studies", "CRE"]
    },
    {
      "className": "Grade 5",
      "gradeLevel": "5",
      "teacherId": "",
      "studentsIds": [],
      "subjects": ["Math", "English", "Kiswahili", "Science", "Social Studies", "CRE"]
    },
    {
      "className": "Grade 6",
      "gradeLevel": "6",
      "teacherId": "",
      "studentsIds": [],
      "subjects": ["Math", "English", "Kiswahili", "Science", "Social Studies", "CRE"]
    },
    {
      "className": "Grade 7",
      "gradeLevel": "7",
      "teacherId": "",
      "studentsIds": [],
      "subjects": ["Math", "English", "Kiswahili", "Integrated Science", "Social Studies", "CRE", "Business Studies"]
    },
    {
      "className": "Grade 8",
      "gradeLevel": "8",
      "teacherId": "",
      "studentsIds": [],
      "subjects": ["Math", "English", "Kiswahili", "Integrated Science", "Social Studies", "CRE", "Business Studies"]
    },
  ];

  for (var cls in classes) {
    await classesCollection.add(cls);
  }

  print("✅ Classes seeded successfully!");
}
