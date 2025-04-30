import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../models/user.dart';

class Operation {
  final String id;
  final String name;
  final String description;
  final List<String> assignedUsers;
  final List<String> requiredMaterials;

  Operation({
    required this.id,
    required this.name,
    required this.description,
    required this.assignedUsers,
    required this.requiredMaterials,
  });
}

class OperationsScreen extends StatelessWidget {
  const OperationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isAdmin = Provider.of<AuthService>(context).isAdmin;
    final currentUser = Provider.of<AuthService>(context).currentUser;

    // TODO: Replace with actual operations list from backend
    final operations = [
      Operation(
        id: 'op1',
        name: 'Assembly Line 1',
        description: 'Main assembly line for product A',
        assignedUsers: ['1', '2'],
        requiredMaterials: ['mat1', 'mat2'],
      ),
      Operation(
        id: 'op2',
        name: 'Quality Check',
        description: 'Quality control station',
        assignedUsers: ['2'],
        requiredMaterials: ['mat3'],
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Operations'),
      ),
      body: ListView.builder(
        itemCount: operations.length,
        itemBuilder: (context, index) {
          final operation = operations[index];
          if (!isAdmin && !currentUser!.canAccessOperation(operation.id)) {
            return const SizedBox.shrink();
          }

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              title: Text(operation.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(operation.description),
                  const SizedBox(height: 4),
                  Text(
                    'Assigned Users: ${operation.assignedUsers.length}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    'Required Materials: ${operation.requiredMaterials.length}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              trailing: isAdmin
                  ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // TODO: Implement edit operation
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            // TODO: Implement delete operation
                          },
                        ),
                      ],
                    )
                  : null,
            ),
          );
        },
      ),
      floatingActionButton: isAdmin
          ? FloatingActionButton(
              onPressed: () {
                // TODO: Implement add operation
              },
              child: const Icon(Icons.add),
            )
          : null,
    );
  }
} 