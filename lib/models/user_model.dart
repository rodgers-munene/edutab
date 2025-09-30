class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String? className;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.className,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? '',
      className: map['class'],
    );
  }
}
