import 'package:flutter/foundation.dart';
import '../models/task_model.dart';
import '../services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  final TaskService _taskService = TaskService();

  List<TaskModel> _tasks = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<TaskModel> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

  List<TaskModel> get pendingTasks =>
      _tasks.where((task) => !task.isCompleted).toList();
  List<TaskModel> get completedTasks =>
      _tasks.where((task) => task.isCompleted).toList();

  // Fetch tasks
  Future<void> fetchTasks() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _tasks = await _taskService.fetchAll();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;notifyListeners();
    }
  }

  // Listen to tasks in real-time
  void listenToTasks() {
    _taskService.streamTasks().listen(
      (tasks) {
        _tasks = tasks;
        _errorMessage = null;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = error.toString();
        notifyListeners();
      },
    );
  }

  // Add a task
  Future<void> addTask(TaskModel task) async {
    try {
      await _taskService.add(task);
      await fetchTasks();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // Update a task
  Future<void> updateTask(TaskModel task) async {
    try {
      await _taskService.update(task);
      await fetchTasks();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // Delete a task
  Future<void> deleteTask(String id) async {
    try {
      await _taskService.delete(id);
      await fetchTasks();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // Toggle task completion
  Future<void> toggleTaskCompletion(String id, bool isCompleted) async {
    try {
      await _taskService.toggleCompletion(id, isCompleted);
      await fetchTasks();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}