part of 'history_bloc.dart';

sealed class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object> get props => [];
}

final class HistoryFetched extends HistoryEvent {}

final class HistoryCreated extends HistoryEvent {
  const HistoryCreated({required this.history});

  final HistoryModel history;

  @override
  List<Object> get props => super.props..add(history);
}

final class HistoryCacheClean extends HistoryEvent {}
