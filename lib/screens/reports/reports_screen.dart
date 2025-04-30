import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/material_service.dart';
import '../../models/material.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports & Analytics'),
      ),
      body: Consumer<MaterialService>(
        builder: (context, materialService, child) {
          final materials = materialService.materials;
          
          // Calculate total inventory value
          final totalInventoryValue = materials.fold<double>(
            0,
            (sum, material) => sum + material.rawMaterialCost,
          );

          // Calculate total manufacturing cost
          final totalManufacturingCost = materials.fold<double>(
            0,
            (sum, material) => sum + material.manufacturingCost,
          );

          // Calculate total potential revenue
          final totalPotentialRevenue = materials.fold<double>(
            0,
            (sum, material) => sum + material.finalProductPrice,
          );

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Summary',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                _buildSummaryCard(
                  context,
                  'Total Inventory Value',
                  '\$${totalInventoryValue.toStringAsFixed(2)}',
                  Icons.inventory,
                ),
                const SizedBox(height: 8),
                _buildSummaryCard(
                  context,
                  'Total Manufacturing Cost',
                  '\$${totalManufacturingCost.toStringAsFixed(2)}',
                  Icons.factory,
                ),
                const SizedBox(height: 8),
                _buildSummaryCard(
                  context,
                  'Total Potential Revenue',
                  '\$${totalPotentialRevenue.toStringAsFixed(2)}',
                  Icons.attach_money,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Material Details',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                ...materials.map((material) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          material.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text('Quantity: ${material.quantity} ${material.unit}'),
                        Text('Unit Cost: \$${material.unitCost.toStringAsFixed(2)}'),
                        Text('Raw Material Cost: \$${material.rawMaterialCost.toStringAsFixed(2)}'),
                        if (material.additionalProcessingCost != null)
                          Text('Processing Cost: \$${material.additionalProcessingCost!.toStringAsFixed(2)}'),
                        Text('Manufacturing Cost: \$${material.manufacturingCost.toStringAsFixed(2)}'),
                        if (material.desiredMargin != null) ...[
                          Text('Desired Margin: ${material.desiredMargin!.toStringAsFixed(2)}%'),
                          Text('Final Price: \$${material.finalProductPrice.toStringAsFixed(2)}'),
                          Text('Profit Margin: ${material.profitMargin!.toStringAsFixed(2)}%'),
                          Text('Suggested Price/Unit: \$${material.suggestedSellingPricePerUnit.toStringAsFixed(2)}'),
                        ],
                      ],
                    ),
                  ),
                )),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Implement export to PDF/Excel
        },
        child: const Icon(Icons.download),
      ),
    );
  }

  Widget _buildSummaryCard(
    BuildContext context,
    String title,
    String value,
    IconData icon,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 