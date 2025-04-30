import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/material_service.dart';
import '../../models/material.dart';

class EditMaterialScreen extends StatefulWidget {
  final MaterialItem material;

  const EditMaterialScreen({super.key, required this.material});

  @override
  State<EditMaterialScreen> createState() => _EditMaterialScreenState();
}

class _EditMaterialScreenState extends State<EditMaterialScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _description;
  late int _quantity;
  late String _unit;
  late double _unitCost;
  late double? _additionalProcessingCost;
  late double? _desiredMargin;

  @override
  void initState() {
    super.initState();
    _name = widget.material.name;
    _description = widget.material.description;
    _quantity = widget.material.quantity;
    _unit = widget.material.unit;
    _unitCost = widget.material.unitCost;
    _additionalProcessingCost = widget.material.additionalProcessingCost;
    _desiredMargin = widget.material.desiredMargin;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Material'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                decoration: const InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a name';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              TextFormField(
                initialValue: _quantity.toString(),
                decoration: const InputDecoration(labelText: 'Quantity'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quantity';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) => _quantity = int.parse(value!),
              ),
              TextFormField(
                initialValue: _unit,
                decoration: const InputDecoration(labelText: 'Unit'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a unit';
                  }
                  return null;
                },
                onSaved: (value) => _unit = value!,
              ),
              TextFormField(
                initialValue: _unitCost.toString(),
                decoration: const InputDecoration(labelText: 'Unit Cost'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a unit cost';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) => _unitCost = double.parse(value!),
              ),
              TextFormField(
                initialValue: _additionalProcessingCost?.toString() ?? '',
                decoration: const InputDecoration(labelText: 'Additional Processing Cost (Optional)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.isNotEmpty && double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) => _additionalProcessingCost = value?.isEmpty ?? true ? null : double.parse(value!),
              ),
              TextFormField(
                initialValue: _desiredMargin?.toString() ?? '',
                decoration: const InputDecoration(labelText: 'Desired Margin % (Optional)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value != null && value.isNotEmpty && double.tryParse(value) == null) {
                    return 'Please enter a valid number';
                  }
                  return null;
                },
                onSaved: (value) => _desiredMargin = value?.isEmpty ?? true ? null : double.parse(value!),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final materialService = Provider.of<MaterialService>(context, listen: false);
                    
                    final updatedMaterial = MaterialItem(
                      id: widget.material.id,
                      name: _name,
                      description: _description,
                      quantity: _quantity,
                      unit: _unit,
                      unitCost: _unitCost,
                      createdAt: widget.material.createdAt,
                      updatedAt: DateTime.now(),
                      additionalProcessingCost: _additionalProcessingCost,
                      desiredMargin: _desiredMargin,
                    );
                    materialService.updateMaterial(updatedMaterial);
                    
                    Navigator.pop(context);
                  }
                },
                child: const Text('Update'),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 