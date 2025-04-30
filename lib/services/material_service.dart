import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/material.dart';

class MaterialService with ChangeNotifier {
  final List<MaterialItem> _materials = [];
  final _uuid = const Uuid();

  List<MaterialItem> get materials => List.unmodifiable(_materials);

  void addMaterial({
    required String name,
    required String description,
    required double unitCost,
    required int quantity,
    required String unit,
    double? additionalProcessingCost,
    double? desiredMargin,
  }) {
    final material = MaterialItem(
      id: _uuid.v4(),
      name: name,
      description: description,
      unitCost: unitCost,
      quantity: quantity,
      unit: unit,
      createdAt: DateTime.now(),
      additionalProcessingCost: additionalProcessingCost,
      desiredMargin: desiredMargin,
    );
    _materials.add(material);
    notifyListeners();
  }

  void updateMaterial(MaterialItem material) {
    final index = _materials.indexWhere((m) => m.id == material.id);
    if (index != -1) {
      _materials[index] = material.copyWith(updatedAt: DateTime.now());
      notifyListeners();
    }
  }

  void deleteMaterial(String id) {
    _materials.removeWhere((material) => material.id == id);
    notifyListeners();
  }

  void updateQuantity(String id, int newQuantity) {
    final index = _materials.indexWhere((m) => m.id == id);
    if (index != -1) {
      _materials[index] = _materials[index].copyWith(
        quantity: newQuantity,
        updatedAt: DateTime.now(),
      );
      notifyListeners();
    }
  }

  void updateProcessingCost(String id, double cost) {
    final index = _materials.indexWhere((m) => m.id == id);
    if (index != -1) {
      _materials[index] = _materials[index].copyWith(
        additionalProcessingCost: cost,
        updatedAt: DateTime.now(),
      );
      notifyListeners();
    }
  }

  void updateDesiredMargin(String id, double margin) {
    final index = _materials.indexWhere((m) => m.id == id);
    if (index != -1) {
      _materials[index] = _materials[index].copyWith(
        desiredMargin: margin,
        updatedAt: DateTime.now(),
      );
      notifyListeners();
    }
  }
} 