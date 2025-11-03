class ProgressModel {
  final String id;
  final String studentId;
  final String subject;
  final double completionPercentage; // 0-100
  final int tasksCompleted;
  final int totalTasks;
  final int videosWatched;
  final int materialsViewed;
  final Map<String, double> subjectScores; // subject -> score
  final DateTime lastUpdated;

  ProgressModel({
    required this.id,
    required this.studentId,
    required this.subject,
    required this.completionPercentage,
    this.tasksCompleted = 0,
    this.totalTasks = 0,
    this.videosWatched = 0,
    this.materialsViewed = 0,
    this.subjectScores = const {},
    required this.lastUpdated,
  });

  factory ProgressModel.fromMap(Map<String, dynamic> map, String id) {
    return ProgressModel(
      id: id,
      studentId: map['studentId'] ?? '',
      subject: map['subject'] ?? '',
      completionPercentage: (map['completionPercentage'] ?? 0.0).toDouble(),
      tasksCompleted: map['tasksCompleted'] ?? 0,
      totalTasks: map['totalTasks'] ?? 0,
      videosWatched: map['videosWatched'] ?? 0,
      materialsViewed: map['materialsViewed'] ?? 0,
      subjectScores: Map<String, double>.from(map['subjectScores'] ?? {}),
      lastUpdated: map['lastUpdated'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['lastUpdated'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'subject': subject,
      'completionPercentage': completionPercentage,
      'tasksCompleted': tasksCompleted,
      'totalTasks': totalTasks,
      'videosWatched': videosWatched,
      'materialsViewed': materialsViewed,
      'subjectScores': subjectScores,
      'lastUpdated': lastUpdated.millisecondsSinceEpoch,
    };
  }
}