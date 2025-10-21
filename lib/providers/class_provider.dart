import 'package:edutab/models/class_model.dart';
import 'package:edutab/services/class_service.dart';
import 'package:flutter/foundation.dart';

class ClassProvider with ChangeNotifier {
  final ClassService _classService = ClassService();
  ClassModel? _currentClass;
  List<String> _subjects = [];

  // Getters
  List<String> get subjects => _subjects;

  ClassModel? get currentClass => _currentClass;

  Future<void> loadClass(String className) async {
    _currentClass = await _classService.getClassByName(className);
    notifyListeners();
  }

  Future<void> loadSubjects(String className) async {
    _subjects = await _classService.getSubjectsByClassName(className);
    notifyListeners();
  }

  Future<void> addStudent(String className, String studentId) async {
    await _classService.addStudentToClass(className, studentId);
    await loadClass(
      className,
    ); // This now correctly reloads the class by its name
  }

  void clearClass() {
    _currentClass = null;
    notifyListeners();
  }

  void clearSubjects() {
    _subjects = [];
    notifyListeners();
  }
}
