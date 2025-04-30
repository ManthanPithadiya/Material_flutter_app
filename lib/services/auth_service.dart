import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/user.dart';

class AuthService with ChangeNotifier {
  User? _currentUser;
  final _uuid = const Uuid();

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;
  bool get isAdmin => _currentUser?.isAdmin ?? false;

  Future<void> login(String email, String password) async {
    // TODO: Implement actual authentication logic
    // For now, we'll use mock data
    if (email == 'admin@example.com' && password == 'admin123') {
      _currentUser = User(
        id: _uuid.v4(),
        name: 'Admin User',
        email: email,
        role: UserRole.admin,
      );
    } else if (email == 'operator@example.com' && password == 'operator123') {
      _currentUser = User(
        id: _uuid.v4(),
        name: 'Operator User',
        email: email,
        role: UserRole.operator,
        assignedOperations: ['op1', 'op2'], // Example assigned operations
      );
    } else {
      throw Exception('Invalid credentials');
    }
    notifyListeners();
  }

  Future<void> logout() async {
    _currentUser = null;
    notifyListeners();
  }
} 