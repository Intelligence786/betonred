import 'package:betonred/data/data_manager.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'progress_event.dart';

part 'progress_state.dart';


class ProgressBloc extends Bloc<ProgressEvent, ProgressState> {
  ProgressBloc() : super(ProgressLoadingState()) {
    on<InitializeProgressEvent>(_onInitializeProgress);
    on<IncrementProgress>(_onIncrementProgress);
    on<ResetProgress>(_onResetProgress);
  }

  void _onInitializeProgress(
      InitializeProgressEvent event, Emitter<ProgressState> emit) async {
    double progressSaved = await DataManager.getProgress();
    emit(ProgressLoadedState(progressSaved, progressSaved >= 1));
  }

  void _onIncrementProgress(
      IncrementProgress event, Emitter<ProgressState> emit) async {
    final newProgress = state.progress + event.amount;

    if (newProgress >= 1) {
      await DataManager.setProgress(0); // Устанавливаем прогресс в 0
      emit(ProgressLoadedState(0, true));
      await unlockNewRecipe();
    } else {
      await DataManager.setProgress(newProgress);
      emit(ProgressLoadedState(newProgress, false));
    }
  }

  void _onResetProgress(ResetProgress event, Emitter<ProgressState> emit) {
    emit(ProgressLoadedState(0, false));
  }

  Future<void> unlockNewRecipe() async {
    DataManager.setPotionIndexKey();
  }
}
