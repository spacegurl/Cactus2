part of 'wikipedia_plants_bloc.dart';

sealed class WikipediaPlantsEvent extends Equatable {
  const WikipediaPlantsEvent();

  @override
  List<Object> get props => [];
}

final class WikipediaPlantsFetched extends WikipediaPlantsEvent {}
