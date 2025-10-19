import 'package:edutab/models/class_model.dart';
import 'package:edutab/services/class_service.dart';
import 'package:flutter/foundation.dart';

class ClassProvider with ChangeNotifier {
  final ClassService _classService = ClassService();
  ClassModel? _currentClass;

  ClassModel? get currentClass => _currentClass;

  Future<void> loadClass(String classId) async {
    _currentClass = await _classService.getClassById(classId);
    notifyListeners();
  }

  Future<void> addStudent(String classId, String studentId) async {
    await _classService.addStudentToClass(classId, studentId);
    await loadClass(classId);
  }

  void clearClass() {
    _currentClass = null;
    notifyListeners();
  }
}
