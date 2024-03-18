import 'dart:async';
import 'dart:math';

import 'package:betonred/data/data_manager.dart';
import 'package:betonred/data/models/potion_model/potion_model.dart';
import 'package:betonred/data/models/task_models/task_model.dart';
import 'package:betonred/data/task_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:uuid/uuid.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskData {
  final TaskState state;
  final List<TaskModel> taskModels;

  TaskData({required this.state, required this.taskModels});
}

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  late Timer _timer;
  List<TaskModel> _activeTasks = [];
  Duration minDuration = Duration(seconds: 10);
  Duration maxDuration = Duration(seconds: 20);

  TaskBloc() : super(TaskInitial()) {
    _startTimer();
    on<TaskFetchEvent>(_onGetTasks);
    //  on<TaskCheckEvent>(_onCheckTask);
    on<TaskCompleteEvent>(_onCompleteTask);
  }

  BehaviorSubject<List<TaskModel>> tasksForDate =
      BehaviorSubject<List<TaskModel>>();

  Stream<List<TaskModel>> get tasks => tasksForDate.stream;

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }

  void _startTimer() async {
    final lastUpdateTime = await TaskManager.getLastUpdateTime();
    final currentTime = DateTime.now();
    final diff = currentTime.difference(lastUpdateTime).inSeconds;
    final random = Random();
    /*  _activeTasks = await TaskManager.getActiveTasks();
    if (_activeTasks.isEmpty) {
      final newTask = TaskModel(
          id: Uuid().v1(), potionModel: DataManager.potionsList[0], count: 2);
      _activeTasks.add(newTask);
      final newTask1 = TaskModel(
          id: Uuid().v1(), potionModel: DataManager.potionsList[1], count: 3);
      _activeTasks.add(newTask1);
      await TaskManager.saveActiveTasks(
          _activeTasks); // Сохраняем активные задачи
      tasksForDate.add(_activeTasks.toList());
    }*/
    void _updateTasks() async {
      if (_activeTasks.isEmpty) {
        _activeTasks = await TaskManager.getActiveTasks();
        tasksForDate.add(_activeTasks.toList());
        if (_activeTasks.isEmpty) {
          final newTask = _generateRandomTask();
          _activeTasks.add(newTask);
          await TaskManager.saveActiveTasks(
              _activeTasks); // Сохраняем активные задачи
          tasksForDate.add(_activeTasks.toList());
        }
      } else if (_activeTasks.length < 5) {
        final newTask = _generateRandomTask();
        _activeTasks.add(newTask);
        await TaskManager.saveActiveTasks(
            _activeTasks); // Сохраняем активные задачи
        tasksForDate.add(_activeTasks.toList());
      }

      _timer = Timer(
        Duration(
          seconds:
              random.nextInt(maxDuration.inSeconds - minDuration.inSeconds) +
                  minDuration.inSeconds,
        ),
        _updateTasks,
      );
      await TaskManager.setLastUpdateTime(DateTime.now());
    }

    if (diff >= minDuration.inSeconds) {
      _updateTasks();
    } else {
      final delay = minDuration.inSeconds - diff;
      _timer = Timer(Duration(seconds: delay), _updateTasks);
    }
  }

  TaskModel _generateRandomTask() {
    final randomPotionIndex = Random().nextInt(DataManager.potionsList.length);
    final randomCount =
        Random().nextInt(4) + 1; // Генерируем от 1 до 4 зелий для задания
    return TaskModel(
      id: Uuid().v1(),
      potionModel: DataManager.potionsList[randomPotionIndex],
      count: randomCount,
    );
  }

  _onGetTasks(TaskFetchEvent event, Emitter<TaskState> emit) async {
    emit(
      TaskLoadingState(),
    );
    _activeTasks =
        await TaskManager.getActiveTasks(); // Загружаем активные задачи
    if (_activeTasks.isEmpty) {
      final newTask = TaskModel(
          id: Uuid().v1(), potionModel: DataManager.potionsList[0], count: 2);
      _activeTasks.add(newTask);
      final newTask1 = TaskModel(
          id: Uuid().v1(), potionModel: DataManager.potionsList[1], count: 3);
      _activeTasks.add(newTask1);
      await TaskManager.saveActiveTasks(
          _activeTasks); // Сохраняем активные задачи
      tasksForDate.add(_activeTasks.toList());
    }
    emit(TaskLoadedState(taskModels: _activeTasks));
  }

  /* _onCheckTask(TaskCheckEvent event, Emitter<TaskState> emit) async {
    final potionToCheck = event.potion;
    final hasPotion =
        _activeTasks.any((task) => task.potionModel.name == potionToCheck.name);

    if (hasPotion) {}

    emit(TaskLoadedState(taskModels: _activeTasks));
  }*/

  _onCompleteTask(TaskCompleteEvent event, Emitter<TaskState> emit) async {
    final currentPotion = event.potion;
    final taskIndex =
        _activeTasks.indexWhere((task) => task.potionModel == currentPotion);
    if (taskIndex != -1) {
      if (_activeTasks[taskIndex].count > 1) {
        _activeTasks[taskIndex].count--;
      } else {
        _activeTasks.removeAt(taskIndex);
      }
      await TaskManager.saveActiveTasks(_activeTasks);
      tasksForDate
          .add(_activeTasks.toList()); // Обновляем данные в tasksForDate
      emit(TaskLoadedState(taskModels: _activeTasks));
    }
  }
}
