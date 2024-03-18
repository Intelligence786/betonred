import '../potion_model/potion_model.dart';

class TaskModel {
  final String id; // Уникальный идентификатор задачи
  final PotionModel potionModel;
   int count;

  TaskModel({required this.id,required this.potionModel,  this.count = 0});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'potionModel': potionModel.toJson(),
      'count': count,
    };
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      potionModel: PotionModel.fromJson(json['potionModel']),
      count: json['count'],
    );
  }
}