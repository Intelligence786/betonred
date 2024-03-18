import 'package:betonred/data/models/supply_model/supply_model.dart';

class PotionModel {
  final String name;
  final String image;
  final List<SupplyModel> suppliesModels;
  final bool isOpened;

  PotionModel({
    required this.name,
    required this.image,
    required this.suppliesModels,
    this.isOpened = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'suppliesModels': suppliesModels.map((supply) => supply.toJson()).toList(),
      'isOpened': isOpened,
    };
  }

  factory PotionModel.fromJson(Map<String, dynamic> json) {
    return PotionModel(
      name: json['name'],
      image: json['image'],
      suppliesModels: (json['suppliesModels'] as List<dynamic>)
          .map((supplyJson) => SupplyModel.fromJson(supplyJson))
          .toList(),
      isOpened: json['isOpened'] ?? false,
    );
  }
}
