class UserModel {
  final String id;
  final String name;
  final String email;
  final String role;
  final String className; // Make sure this exists
  // ... other properties

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.className,
    // ... other properties
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      id: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? '',
      className: map['className'] ?? '',
      // ... other properties
    );
  }

  // ... rest of the class implementation
}
