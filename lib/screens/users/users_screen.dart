import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../models/user.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users Management'),
      ),
      body: Consumer<AuthService>(
        builder: (context, authService, child) {
          // TODO: Replace with actual user list from backend
          final users = [
            User(
              id: '1',
              name: 'Admin User',
              email: 'admin@example.com',
              role: UserRole.admin,
            ),
            User(
              id: '2',
              name: 'Operator User',
              email: 'operator@example.com',
              role: UserRole.operator,
              assignedOperations: ['op1', 'op2'],
            ),
          ];

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user.name),
                subtitle: Text('${user.email} - ${user.role.toString().split('.').last}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // TODO: Implement edit user
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        // TODO: Implement delete user
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement add user
        },
        child: const Icon(Icons.add),
      ),
    );
  }
} 