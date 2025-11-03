import 'package:flutter/foundation.dart';
import '../models/video_model.dart';
import '../services/video_service.dart';

class VideoProvider extends ChangeNotifier {
  final VideoService _videoService = VideoService();

  List<VideoModel> _videos = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<VideoModel> get videos => _videos;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

  // Fetch videos
  Future<void> fetchVideos() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _videos = await _videoService.fetchAll();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Listen to videos in real-time
  void listenToVideos() {
    _videoService.streamVideos().listen(
      (videos) {
        _videos = videos;
        _errorMessage = null;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = error.toString();
        notifyListeners();
      },
    );
  }

  // Add a video
  Future<void> addVideo(VideoModel video) async {
    try {
      await _videoService.add(video);
      await fetchVideos();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // Update a video
  Future<void> updateVideo(VideoModel video) async {
    try {
      await _videoService.update(video);
      await fetchVideos();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // Delete a video
  Future<void> deleteVideo(String id) async {
    try {
      await _videoService.delete(id);
      await fetchVideos();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // Increment views
  Future<void> incrementViews(String id) async {
    try {
      await _videoService.incrementViews(id);
      // Update the local list
      final index = _videos.indexWhere((v) => v.id == id);
      if (index != -1) {
        _videos[index] = VideoModel(
          id: _videos[index].id,
          title: _videos[index].title,
          description: _videos[index].description,
          subject: _videos[index].subject,
          thumbnailUrl: _videos[index].thumbnailUrl,
          videoUrl: _videos[index].videoUrl,
          durationInSeconds: _videos[index].durationInSeconds,
          uploadedBy: _videos[index].uploadedBy,
          views: _videos[index].views + 1,
          uploadedAt: _videos[index].uploadedAt,
        );
        notifyListeners();
      }
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Get videos by subject
  Future<List<VideoModel>> getVideosBySubject(String subject) async {
    try {
      return await _videoService.fetchBySubject(subject);
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      return [];
    }
  }

  // Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}