import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'hunt_time_event.dart';
part 'hunt_time_state.dart';

class HuntTimeCubit extends Cubit<HuntTimeState> {
  late Timer _timer;
  DateTime? savedDateTime;
  bool isSearchEnabled = true;
  Duration huntDuration = Duration(minutes: 20); // Длительность охоты - 20 минут

  HuntTimeCubit() : super(HuntTimeInitialState()) {
    _loadSavedData();
  }

  void _loadSavedData() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMilliseconds = prefs.getInt('saved_datetime');
    savedDateTime = savedMilliseconds != null
        ? DateTime.fromMillisecondsSinceEpoch(savedMilliseconds)
        : null;

    if (savedDateTime != null) {
      final timeDifference = DateTime.now().difference(savedDateTime!);
      if (timeDifference < huntDuration) {
        // Если прошло менее 20 минут, начинаем отсчет с оставшегося времени
        huntDuration -= timeDifference;
        isSearchEnabled = false;
        startTimer();
      } else {
        // Если прошло более 20 минут или нет сохраненной даты, начинаем отсчет заново
        savedDateTime = DateTime.now();
        prefs.setInt('saved_datetime', savedDateTime!.millisecondsSinceEpoch);
        startTimer();
      }
    } else {
      // Если нет сохраненной даты, начинаем отсчет заново
      savedDateTime = DateTime.now();
      prefs.setInt('saved_datetime', savedDateTime!.millisecondsSinceEpoch);
      startTimer();
    }

    emit(HuntTimeUpdatedState(huntDuration.inSeconds, isSearchEnabled));
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (huntDuration.inSeconds > 0) {
        huntDuration -= Duration(seconds: 1);
        emit(HuntTimeUpdatedState(huntDuration.inSeconds, isSearchEnabled));
      } else {
        isSearchEnabled = true;
        _timer.cancel();
        emit(HuntTimeUpdatedState(huntDuration.inSeconds, isSearchEnabled));
      }
    });
  }

  void startSearch() {
    isSearchEnabled = false;
    emit(HuntTimeUpdatedState(huntDuration.inSeconds, isSearchEnabled));
  }

  @override
  Future<void> close() {
    _timer.cancel();
    return super.close();
  }
}
