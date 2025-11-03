import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/progress_model.dart';
import '../services/progress_service.dart';

class ProgressProvider extends ChangeNotifier {
  final ProgressService _progressService = ProgressService();

  ProgressModel? _progress;
  bool _isLoading = false;
  String? _errorMessage;

  ProgressModel? get progress => _progress;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

  // Fetch progress
  Future<void> fetchProgress() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _errorMessage = 'No user logged in';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _progress = await _progressService.fetchStudentProgress(user.uid);
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  // Listen to progress in real-time
  void listenToProgress() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _errorMessage = 'No user logged in';
      notifyListeners();
      return;
    }

    _progressService.streamProgress(user.uid).listen(
      (progress) {
        _progress = progress;
        _errorMessage = null;
        notifyListeners();
      },
      onError: (error) {
        _errorMessage = error.toString();
        notifyListeners();
      },
    );
  }

  // Update progress
  Future<void> updateProgress(ProgressModel progress) async {
    try {
      await _progressService.update(progress);
      await fetchProgress();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
      rethrow;
    }
  }

  // Update completion percentage
  Future<void> updateCompletion(double percentage) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await _progressService.updateCompletion(user.uid, percentage);
      await fetchProgress();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Update task statistics
  Future<void> updateTaskStats(int completed, int total) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await _progressService.updateTaskStats(user.uid, completed, total);
      await fetchProgress();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Increment videos watched
  Future<void> incrementVideosWatched() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await _progressService.incrementVideosWatched(user.uid);
      await fetchProgress();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Increment materials viewed
  Future<void> incrementMaterialsViewed() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await _progressService.incrementMaterialsViewed(user.uid);
      await fetchProgress();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Update subject score
  Future<void> updateSubjectScore(String subject, double score) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    try {
      await _progressService.updateSubjectScore(user.uid, subject, score);
      await fetchProgress();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Clear error
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}