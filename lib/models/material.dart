class MaterialItem {
  final String id;
  final String name;
  final String description;
  final double unitCost;
  final int quantity;
  final String unit;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final double? additionalProcessingCost;
  final double? desiredMargin;

  MaterialItem({
    required this.id,
    required this.name,
    required this.description,
    required this.unitCost,
    required this.quantity,
    required this.unit,
    required this.createdAt,
    this.updatedAt,
    this.additionalProcessingCost,
    this.desiredMargin,
  });

  // Calculate raw material cost
  double get rawMaterialCost => unitCost * quantity;

  // Calculate manufacturing cost
  double get manufacturingCost => rawMaterialCost + (additionalProcessingCost ?? 0);

  // Calculate final product price
  double get finalProductPrice {
    if (desiredMargin == null) return manufacturingCost;
    return manufacturingCost * (1 + (desiredMargin! / 100));
  }

  // Calculate profit margin
  double? get profitMargin {
    if (desiredMargin == null) return null;
    return (finalProductPrice - manufacturingCost) / finalProductPrice * 100;
  }

  // Calculate suggested selling price per unit
  double get suggestedSellingPricePerUnit => finalProductPrice / quantity;

  MaterialItem copyWith({
    String? id,
    String? name,
    String? description,
    double? unitCost,
    int? quantity,
    String? unit,
    DateTime? createdAt,
    DateTime? updatedAt,
    double? additionalProcessingCost,
    double? desiredMargin,
  }) {
    return MaterialItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      unitCost: unitCost ?? this.unitCost,
      quantity: quantity ?? this.quantity,
      unit: unit ?? this.unit,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      additionalProcessingCost: additionalProcessingCost ?? this.additionalProcessingCost,
      desiredMargin: desiredMargin ?? this.desiredMargin,
    );
  }
} 