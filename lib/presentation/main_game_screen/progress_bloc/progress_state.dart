part of 'progress_bloc.dart';

abstract class ProgressState extends Equatable {
  final double progress;
  final bool isOpened;

  ProgressState(this.progress, this.isOpened);

  @override
  List<Object?> get props => [progress, isOpened];
}

class ProgressLoadingState extends ProgressState {
  ProgressLoadingState() : super(0, false);
}

class ProgressLoadedState extends ProgressState {
  ProgressLoadedState(double progress, bool isOpened) : super(progress, isOpened);
}