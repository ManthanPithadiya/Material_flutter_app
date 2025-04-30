import 'package:flutter/foundation.dart';

class User {
  final String email;
  final String role;

  User({required this.email, required this.role});
}

class AuthService with ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  // Predefined users
  final Map<String, Map<String, dynamic>> _users = {
    'd23it183@charusat.edu.in': {
      'password': 'Test1234',
      'role': 'operator',
    },
    'admin183@gmail.com': {
      'password': 'Test1234',
      'role': 'admin',
    },
  };

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAdmin => _user?.role == 'admin';
  bool get isOperator => _user?.role == 'operator';

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay

    if (_users.containsKey(email) && _users[email]!['password'] == password) {
      _user = User(
        email: email,
        role: _users[email]!['role'],
      );
    } else {
      throw 'Invalid email or password';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> signOut() async {
    _user = null;
    notifyListeners();
  }
} 