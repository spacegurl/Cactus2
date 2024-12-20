part of 'history_bloc.dart';

sealed class HistoryState extends Equatable {
  const HistoryState(this.historyList);

  final List<HistoryModel> historyList;

  @override
  List<Object> get props => [historyList];
}

final class HistoryInitial extends HistoryState {
  const HistoryInitial(super.historyList);
}

final class HistoryLoading extends HistoryState {
  const HistoryLoading(super.historyList);
}

final class HistorySuccess extends HistoryState {
  const HistorySuccess(super.historyList);
}

final class HistoryFailure extends HistoryState {
  const HistoryFailure(super.historyList, {required this.error});

  final Object error;

  @override
  List<Object> get props => super.props..add(error);
}
