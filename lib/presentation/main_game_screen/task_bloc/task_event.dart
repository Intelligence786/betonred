part of 'task_bloc.dart';

@immutable
abstract class TaskEvent {}

class TaskFetchEvent extends TaskEvent {}

class TaskCompleteEvent extends TaskEvent {
  final PotionModel potion;

  TaskCompleteEvent({required this.potion});
}

class TaskCheckEvent extends TaskEvent {
  final PotionModel potion;

  TaskCheckEvent(this.potion);
}
