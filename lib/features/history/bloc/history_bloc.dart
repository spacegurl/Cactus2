import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cactus/repo/repo.dart';
import 'package:equatable/equatable.dart';

part 'history_event.dart';

part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  HistoryBloc({required HistoryRepo historyRepo})
      : _historyRepo = historyRepo,
        super(const HistoryInitial([])) {
    on<HistoryFetched>(_fetchHistoryList);
    on<HistoryCreated>(_createHistory);
    on<HistoryCacheClean>(_cacheClean);
  }

  final HistoryRepo _historyRepo;

  Future<void> _fetchHistoryList(
    HistoryFetched event,
    Emitter<HistoryState> emit,
  ) async {
    emit(HistoryLoading(state.historyList));

    try {
      final historyList = await _historyRepo.getHistory();

      emit(HistorySuccess(historyList));
    } catch (e) {
      emit(HistoryFailure(state.historyList, error: e));
    }
  }

  Future<void> _createHistory(
    HistoryCreated event,
    Emitter<HistoryState> emit,
  ) async {
    emit(HistoryLoading(state.historyList));

    try {
      final newHistory = await _historyRepo.createHistory(event.history);
      final historyList = [...state.historyList];
      historyList.add(newHistory);

      emit(HistorySuccess(historyList));
    } catch (e) {
      emit(HistoryFailure(state.historyList, error: e));
    }
  }

  Future<void> _cacheClean(
    HistoryCacheClean event,
    Emitter<HistoryState> emit,
  ) async {
    emit(const HistorySuccess([]));
  }
}
