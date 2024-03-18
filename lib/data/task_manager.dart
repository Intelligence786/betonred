import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'models/task_models/task_model.dart';

class TaskManager {
  static const _taskKey = 'active_tasks';
  static const _lastUpdateTimeKey = 'last_update_time';

  static Future<List<TaskModel>> getActiveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getString(_taskKey);
    if (tasksJson != null) {
      final List<dynamic> tasksData = json.decode(tasksJson);
      return tasksData.map((taskJson) => TaskModel.fromJson(taskJson)).toList();
    } else {
      return [];
    }
  }

  static Future<void> saveActiveTasks(List<TaskModel> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final List<dynamic> tasksJson = tasks.map((task) => task.toJson()).toList();
    final tasksString = json.encode(tasksJson);
    await prefs.setString(_taskKey, tasksString);
  }

  static Future<DateTime> getLastUpdateTime() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getInt(_lastUpdateTimeKey);
    return timestamp != null
        ? DateTime.fromMillisecondsSinceEpoch(timestamp)
        : DateTime.now();
  }

  static Future<void> setLastUpdateTime(DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_lastUpdateTimeKey, time.millisecondsSinceEpoch);
  }

  static Future<void> completeTask(TaskModel task) async {
    final activeTasks = await getActiveTasks();

    final taskIndex = activeTasks.indexWhere((element) => element.id == task.id);
    if (activeTasks[taskIndex].count > 1) {
      activeTasks[taskIndex].count--;
    } else {
      // Если количество задач равно 1 или меньше, удаляем задачу из списка
      activeTasks.removeAt(taskIndex);
    }

    // Сохраняем обновленный список задач
    await saveActiveTasks(activeTasks);
  }
}
