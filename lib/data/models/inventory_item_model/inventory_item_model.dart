import 'package:betonred/data/models/supply_model/supply_model.dart';

class InventoryItemModel {
  final SupplyModel supply;
  int quantity;

  InventoryItemModel({required this.supply, required this.quantity});

  Map<String, dynamic> toJson() {
    return {
      'id': supply.id,
      'name': supply.name,
      'image': supply.image,
      'quantity': quantity,
    };
  }

  factory InventoryItemModel.fromJson(Map<String, dynamic> json) {
    return InventoryItemModel(
      supply: SupplyModel(id: json['id'], name: json['name'], image: json['image']),
      quantity: json['quantity'],
    );
  }
}