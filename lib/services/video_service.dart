import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/video_model.dart';

class VideoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _collection = 'videos';

  // Fetch all videos
  Future<List<VideoModel>> fetchAll() async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .orderBy('uploadedAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => VideoModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch videos: $e');
    }
  }

  // Listen to videos in real-time
  Stream<List<VideoModel>> streamVideos() {
    return _firestore
        .collection(_collection)
        .orderBy('uploadedAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => VideoModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  // Add a new video
  Future<void> add(VideoModel video) async {
    try {
      await _firestore.collection(_collection).add(video.toMap());
    } catch (e) {
      throw Exception('Failed to add video: $e');
    }
  }

  // Update a video
  Future<void> update(VideoModel video) async {
    try {
      await _firestore
          .collection(_collection)
          .doc(video.id)
          .update(video.toMap());
    } catch (e) {
      throw Exception('Failed to update video: $e');
    }
  }

  // Delete a video
  Future<void> delete(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).delete();
    } catch (e) {
      throw Exception('Failed to delete video: $e');
    }
  }

  // Increment video views
  Future<void> incrementViews(String id) async {
    try {
      await _firestore.collection(_collection).doc(id).update({
        'views': FieldValue.increment(1),
      });
    } catch (e) {
      throw Exception('Failed to increment views: $e');
    }
  }

  // Fetch videos by subject
  Future<List<VideoModel>> fetchBySubject(String subject) async {
    try {
      final snapshot = await _firestore
          .collection(_collection)
          .where('subject', isEqualTo: subject)
          .orderBy('uploadedAt', descending: true)
          .get();

      return snapshot.docs
          .map((doc) => VideoModel.fromMap(doc.data(), doc.id))
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch videos by subject: $e');
    }
  }
}