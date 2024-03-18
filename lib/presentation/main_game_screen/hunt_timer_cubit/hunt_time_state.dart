part of 'hunt_time_cubit.dart';

@immutable
sealed class HuntTimeState extends Equatable {
  const HuntTimeState();

  @override
  List<Object> get props => [];
}

class HuntTimeInitialState extends HuntTimeState {}

class HuntTimeUpdatedState extends HuntTimeState {
  final int timeRemaining;
  final bool isSearchEnabled;

  HuntTimeUpdatedState(this.timeRemaining, this.isSearchEnabled);

  @override
  List<Object> get props => [timeRemaining, isSearchEnabled];
}