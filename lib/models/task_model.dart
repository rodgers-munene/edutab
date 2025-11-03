class TaskModel {
  final String id;
  final String title;
  final String description;
  final String subject;
  final DateTime dueDate;
  final String priority; // high, medium, low
  final bool isCompleted;
  final String? attachmentUrl;
  final DateTime createdAt;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.subject,
    required this.dueDate,
    required this.priority,
    this.isCompleted = false,
    this.attachmentUrl,
    required this.createdAt,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map, String id) {
    return TaskModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      subject: map['subject'] ?? '',
      dueDate: map['dueDate'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['dueDate'])
          : DateTime.now(),
      priority: map['priority'] ?? 'medium',
      isCompleted: map['isCompleted'] ?? false,
      attachmentUrl: map['attachmentUrl'],
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'subject': subject,
      'dueDate': dueDate.millisecondsSinceEpoch,
      'priority': priority,
      'isCompleted': isCompleted,
      'attachmentUrl': attachmentUrl,
      'createdAt': createdAt.millisecondsSinceEpoch,
    };
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? subject,
    DateTime? dueDate,
    String? priority,
    bool? isCompleted,
    String? attachmentUrl,
    DateTime? createdAt,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      subject: subject ?? this.subject,
      dueDate: dueDate ?? this.dueDate,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}