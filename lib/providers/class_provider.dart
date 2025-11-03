import 'package:edutab/models/class_model.dart';
import 'package:edutab/services/class_service.dart';
import 'package:flutter/foundation.dart';

class ClassProvider with ChangeNotifier {
  final ClassService _classService = ClassService();
  ClassModel? _currentClass;
  List<String> _subjects = [];
  bool _isLoading = false;
  String _errorMessage = '';

  // Getters
  List<String> get subjects => _subjects;
  ClassModel? get currentClass => _currentClass;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Load student's class by className
  Future<void> loadClass(String className) async {
    _isLoading = true;
    notifyListeners();

    try {
      _currentClass = await _classService.getClassByName(className);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Load subjects for student's class
  Future<void> loadSubjects(String className) async {
    try {
      _subjects = await _classService.getSubjectsByClassName(className);
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Load student's class and subjects in one call
  Future<void> loadStudentClass(String className) async {
    _isLoading = true;
    notifyListeners();

    try {
      _currentClass = await _classService.getClassByName(className);
      if (_currentClass != null) {
        _subjects = _currentClass!.subjects;
      }
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Add student to class (used during registration)
  Future<void> addStudent(String className, String studentId) async {
    try {
      await _classService.addStudentToClass(className, studentId);
      await loadClass(className);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  void clearClass() {
    _currentClass = null;
    notifyListeners();
  }

  void clearSubjects() {
    _subjects = [];
    notifyListeners();
  }

  void clearAll() {
    _currentClass = null;
    _subjects = [];
    _isLoading = false;
    _errorMessage = '';
    notifyListeners();
  }
}