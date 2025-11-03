import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/progress_model.dart';

class ProgressService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'students_progress';

  // Fetch progress for a student
  Future<ProgressModel?> fetchStudentProgress(String studentId) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .doc(studentId)
          .get();

      if (snapshot.exists) {
        return ProgressModel.fromMap(snapshot.data()!, snapshot.id);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to fetch progress: $e');
    }
  }

  // Listen to progress in real-time
  Stream<ProgressModel?> streamProgress(String studentId) {
    return _firestore
        .collection(_collection)
        .doc(studentId)
        .snapshots()
        .map((snapshot) {
      if (snapshot.exists) {
        return ProgressModel.fromMap(snapshot.data()!, snapshot.id);
      }
      return null;
    });
  }

  // Update progress
  Future<void> update(ProgressModel progress) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(progress.id)
          .set(progress.toMap(), SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to update progress: $e');
    }
  }

  // Update completion percentage
  Future<void> updateCompletion(String studentId, double percentage) async {
    try {
      await _firestore.collection(_collection).doc(studentId).update({
        'completionPercentage': percentage,
        'lastUpdated': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      throw Exception('Failed to update completion: $e');
    }
  }

  // Update task stats
  Future<void> updateTaskStats(
      String studentId, int completed, int total) async {
    try {
      await _firestore.collection(_collection).doc(studentId).update({
        'tasksCompleted': completed,
        'totalTasks': total,
        'lastUpdated': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      throw Exception('Failed to update task stats: $e');
    }
  }

  // Increment videos watched
  Future<void> incrementVideosWatched(String studentId) async {
    try {
      await _firestore.collection(_collection).doc(studentId).update({
        'videosWatched': FieldValue.increment(1),
        'lastUpdated': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      throw Exception('Failed to increment videos watched: $e');
    }
  }

  // Increment materials viewed
  Future<void> incrementMaterialsViewed(String studentId) async {
    try {
      await _firestore.collection(_collection).doc(studentId).update({
        'materialsViewed': FieldValue.increment(1),
        'lastUpdated': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      throw Exception('Failed to increment materials viewed: $e');
    }
  }

  // Update subject score
  Future<void> updateSubjectScore(
      String studentId, String subject, double score) async {
    try {
      await _firestore.collection(_collection).doc(studentId).update({
        'subjectScores.$subject': score,
        'lastUpdated': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      throw Exception('Failed to update subject score: $e');
    }
  }
}