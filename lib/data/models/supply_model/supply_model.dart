class SupplyModel {
  final int id;
  final String name;
  final String image;

  SupplyModel({required this.id, required this.name, required this.image});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
    };
  }

  factory SupplyModel.fromJson(Map<String, dynamic> json) {
    return SupplyModel(
      id: json['id'],
      name: json['name'],
      image: json['image'],
    );
  }
}