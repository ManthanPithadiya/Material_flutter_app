import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../materials/materials_screen.dart';
import '../operations/operations_screen.dart';
import '../reports/reports_screen.dart';
import '../users/users_screen.dart';
import '../scan/scan_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isAdmin = Provider.of<AuthService>(context).isAdmin;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Material Tracking'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await Provider.of<AuthService>(context, listen: false).logout();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
          ),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildFeatureCard(
            context,
            'Materials',
            Icons.inventory,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MaterialsScreen()),
            ),
          ),
          if (isAdmin) ...[
            _buildFeatureCard(
              context,
              'Users',
              Icons.people,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UsersScreen()),
              ),
            ),
            _buildFeatureCard(
              context,
              'Operations',
              Icons.engineering,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OperationsScreen()),
              ),
            ),
            _buildFeatureCard(
              context,
              'Reports',
              Icons.analytics,
              () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ReportsScreen()),
              ),
            ),
          ],
          _buildFeatureCard(
            context,
            'Scan',
            Icons.qr_code_scanner,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ScanScreen()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
  ) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48),
            const SizedBox(height: 8),
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
} 