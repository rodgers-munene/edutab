import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:edutab/models/class_model.dart';

class ClassService {
  final _firestore = FirebaseFirestore.instance;

  Future<ClassModel?> getClassByName(String className) async {
    try {
      final doc = await _firestore
          .collection('classes')
          .where("className", isEqualTo: className)
          .get();
      if (doc.docs.isNotEmpty) {
        final classDoc = doc.docs.first;
        return ClassModel.fromMap(classDoc.data(), classDoc.id);
      }

      return null;
    } catch (e) {
      print("Error fetching class: $e");
      return null;
    }
  }

  Future<void> createClass(ClassModel classModel) async {
    try {
      await _firestore
          .collection('classes')
          .doc(classModel.id)
          .set(classModel.toMap());
    } catch (e) {
      print('Error creating class: $e');
    }
  }

  Future<void> addStudentToClass(String className, String studentId) async {
    try {
      final classRef = await _firestore
          .collection('classes')
          .where('className', isEqualTo: className)
          .get();

      if (classRef.docs.isNotEmpty) {
        final classDoc = classRef.docs.first;
        final List students = List.from(classDoc['studentsIds'] ?? []);

        // add student if student is not on the list
        if (!students.contains(studentId)) {
          students.add(studentId);
          await classDoc.reference.update({'studentsIds': students});
          print('Student added to class $className');
        } else {
          print('Student already in class $className');
        }
      } else {
        print('No class found with name $className');
      }
    } catch (e) {
      print('Error adding student: $e');
    }
  }

  Future<void> removeStudentFromClass(String classId, String studentId) async {
    try {
      final classRef = _firestore.collection('classes').doc(classId);
      await classRef.update({
        'studentsIds': FieldValue.arrayRemove([studentId]), // Corrected
      });
    } catch (e) {
      print("Error removing student: $e");
    }
  }

  Future<List<ClassModel>> getClassesByGrade(String gradeLevel) async {
    try {
      final querySnapshot = await _firestore
          .collection('classes')
          .where('gradeLevel', isEqualTo: gradeLevel)
          .get();
      return querySnapshot.docs
          .map((doc) => ClassModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print("Error fetching classes by grade: $e");
      return [];
    }
  }

  Future<List<String>> getSubjectsByClassName(String className) async {
    try {
      final querySnapshot = await _firestore
          .collection('classes')
          .where('className', isEqualTo: className)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        final data = doc.data();
        final lessons = List<String>.from(data['subjects'] ?? []);
        return lessons;
      } else {
        print("No class found for name $className");
        return [];
      }
    } catch (e) {
      print("Error fetching student's lessons: $e");
      return [];
    }
  }
}
