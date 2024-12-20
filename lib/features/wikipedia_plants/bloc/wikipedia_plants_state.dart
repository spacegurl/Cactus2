part of 'wikipedia_plants_bloc.dart';

sealed class WikipediaPlantsState extends Equatable {
  const WikipediaPlantsState(this.plants);

  final List<PlantModel> plants;

  @override
  List<Object> get props => [plants];
}

final class WikipediaPlantsInitial extends WikipediaPlantsState {
  const WikipediaPlantsInitial(super.plants);
}

final class WikipediaPlantsLoading extends WikipediaPlantsState {
  const WikipediaPlantsLoading(super.plants);
}

final class WikipediaPlantsSuccess extends WikipediaPlantsState {
  const WikipediaPlantsSuccess(super.plants);
}

final class WikipediaPlantsFailure extends WikipediaPlantsState {
  const WikipediaPlantsFailure(super.plants, {required this.error});

  final Object error;

  @override
  List<Object> get props => super.props..add(error);
}
