enum UserRole { admin, operator }

class User {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final List<String>? assignedOperations;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.assignedOperations,
  });

  bool get isAdmin => role == UserRole.admin;
  bool get isOperator => role == UserRole.operator;

  bool canAccessOperation(String operationId) {
    if (isAdmin) return true;
    return assignedOperations?.contains(operationId) ?? false;
  }
} 