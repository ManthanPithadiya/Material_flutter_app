import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/material_service.dart';
import '../../models/material.dart';
import 'add_material_screen.dart';
import 'edit_material_screen.dart';

class MaterialsScreen extends StatelessWidget {
  const MaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Materials'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddMaterialScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Consumer<MaterialService>(
        builder: (context, materialService, child) {
          final materials = materialService.materials;
          if (materials.isEmpty) {
            return const Center(
              child: Text('No materials added yet'),
            );
          }
          return ListView.builder(
            itemCount: materials.length,
            itemBuilder: (context, index) {
              final material = materials[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(material.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${material.quantity} ${material.unit}'),
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditMaterialScreen(
                          material: material,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
} 