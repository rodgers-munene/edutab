class MaterialModel {
  final String id;
  final String title;
  final String description;
  final String subject;
  final String type; // pdf, doc, image, link
  final String url;
  final String uploadedBy;
  final int sizeInBytes;
  final DateTime uploadedAt;

  MaterialModel({
    required this.id,
    required this.title,
    required this.description,
    required this.subject,
    required this.type,
    required this.url,
    required this.uploadedBy,
    this.sizeInBytes = 0,
    required this.uploadedAt,
  });

  factory MaterialModel.fromMap(Map<String, dynamic> map, String id) {
    return MaterialModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      subject: map['subject'] ?? '',
      type: map['type'] ?? 'pdf',
      url: map['url'] ?? '',
      uploadedBy: map['uploadedBy'] ?? '',
      sizeInBytes: map['sizeInBytes'] ?? 0,
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
      'type': type,
      'url': url,
      'uploadedBy': uploadedBy,
      'sizeInBytes': sizeInBytes,
      'uploadedAt': uploadedAt.millisecondsSinceEpoch,
    };
  }

  String get formattedSize {
    if (sizeInBytes < 1024) return '$sizeInBytes B';
    if (sizeInBytes < 1024 * 1024) {
      return '${(sizeInBytes / 1024).toStringAsFixed(1)} KB';
    }
    return '${(sizeInBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}