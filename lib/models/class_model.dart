class ClassModel {
  final String id;
  final String className;
  final String gradeLevel;
  final String teacherId;
  final List<String> studentsIds;
  final List<String> subjects;

  ClassModel({
    required this.id,
    required this.className,
    required this.gradeLevel,
    required this.teacherId,
    required this.studentsIds,
    required this.subjects,
  });

  factory ClassModel.fromMap(Map<String, dynamic> map, String id) {
    return ClassModel(
      id: id,
      className: map['className'] ?? '',
      gradeLevel: map['gradeLevel'] ?? '', 
      teacherId: map['teacherId'] ?? '',
      studentsIds: List<String>.from(map['studentsIds'] ?? []),
      subjects: List<String>.from(map['subjects'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'className': className,
      'gradeLevel': gradeLevel, 
      'teacherId': teacherId,
      'studentsIds': studentsIds,
      'subjects': subjects,
    };
  }
}
