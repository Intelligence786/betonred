part of 'hunt_time_cubit.dart';

class HuntTimeEvent extends Equatable {
  const HuntTimeEvent();

  @override
  List<Object> get props => [];
}

class HuntTimeStarted extends HuntTimeEvent {}

class HuntTimeUpdated extends HuntTimeEvent {
  final int timeRemaining;
  final bool isSearchEnabled;

  HuntTimeUpdated(this.timeRemaining, this.isSearchEnabled);

  @override
  List<Object> get props => [timeRemaining, isSearchEnabled];
}