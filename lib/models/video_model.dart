class VideoModel {
  final String id;
  final String title;
  final String description;
  final String subject;
  final String thumbnailUrl;
  final String videoUrl;
  final int durationInSeconds;
  final String uploadedBy;
  final int views;
  final DateTime uploadedAt;

  VideoModel({
    required this.id,
    required this.title,
    required this.description,
    required this.subject,
    required this.thumbnailUrl,
    required this.videoUrl,
    this.durationInSeconds = 0,
    required this.uploadedBy,
    this.views = 0,
    required this.uploadedAt,
  });

  factory VideoModel.fromMap(Map<String, dynamic> map, String id) {
    return VideoModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      subject: map['subject'] ?? '',
      thumbnailUrl: map['thumbnailUrl'] ?? '',
      videoUrl: map['videoUrl'] ?? '',
      durationInSeconds: map['durationInSeconds'] ?? 0,
      uploadedBy: map['uploadedBy'] ?? '',
      views: map['views'] ?? 0,
      uploadedAt: map['uploadedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['uploadedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'subject': subject,
      'thumbnailUrl': thumbnailUrl,
      'videoUrl': videoUrl,
      'durationInSeconds': durationInSeconds,
      'uploadedBy': uploadedBy,
      'views': views,
      'uploadedAt': uploadedAt.millisecondsSinceEpoch,
    };
  }

  String get formattedDuration {
    final minutes = durationInSeconds ~/ 60;
    final seconds = durationInSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}