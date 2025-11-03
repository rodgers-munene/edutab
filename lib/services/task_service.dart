import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task_model.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'tasks';

  // Fetch all tasks
  Future<List<TaskModel>> fetchAll() async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .orderBy('dueDate', descending: false)
          .get();

      return snapshot.docs
          .map((doc) => TaskModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch tasks: $e');
    }
  }

  // Listen to tasks in real-time
  Stream<List<TaskModel>> streamTasks() {
    return _firestore
        .collection(_collection)
        .orderBy('dueDate', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => TaskModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  // Add a new task
  Future<void> add(TaskModel task) async {
    try {
      await _firestore.collection(_collection).add(task.toMap());
    } catch (e) {
      throw Exception('Failed to add task: $e');
    }
  }

  // Update a task
  Future<void> update(TaskModel task) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(task.id)
          .update(task.toMap());
    } catch (e) {
      throw Exception('Failed to update task: $e');
    }
  }

  // Delete a task
  Future<void> delete(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete task: $e');
    }
  }

  // Toggle task completion
  Future<void> toggleCompletion(String id, bool isCompleted) async {
    try {
      await _firestore.collection(_collection).doc(id).update({
        'isCompleted': isCompleted,
      });
    } catch (e) {
      throw Exception('Failed to toggle task completion: $e');
    }
  }

  // Fetch pending tasks
  Future<List<TaskModel>> fetchPendingTasks() async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('isCompleted', isEqualTo: false)
          .orderBy('dueDate', descending: false)
          .get();

      return snapshot.docs
          .map((doc) => TaskModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch pending tasks: $e');
    }
  }
}