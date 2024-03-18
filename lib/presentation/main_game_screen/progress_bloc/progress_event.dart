part of 'progress_bloc.dart';

abstract class ProgressEvent {}

class InitializeProgressEvent extends ProgressEvent {}

class IncrementProgress extends ProgressEvent {
  final double amount;

  IncrementProgress(this.amount);
}

class ResetProgress extends ProgressEvent {}