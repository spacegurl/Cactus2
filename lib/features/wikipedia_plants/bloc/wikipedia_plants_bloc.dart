import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cactus/repo/repo.dart';
import 'package:equatable/equatable.dart';

part 'wikipedia_plants_event.dart';

part 'wikipedia_plants_state.dart';

class WikipediaPlantsBloc
    extends Bloc<WikipediaPlantsEvent, WikipediaPlantsState> {
  WikipediaPlantsBloc({required PlantRepo plantRepo})
      : _plantRepo = plantRepo,
        super(const WikipediaPlantsInitial([])) {
    on<WikipediaPlantsFetched>(_fetchPlants);
  }

  final PlantRepo _plantRepo;

  Future<void> _fetchPlants(
    WikipediaPlantsFetched event,
    Emitter<WikipediaPlantsState> emit,
  ) async {
    emit(WikipediaPlantsLoading(state.plants));

    try {
      final plants = await _plantRepo.getPlants();

      emit(WikipediaPlantsSuccess(plants));
    } catch (e) {
      emit(WikipediaPlantsFailure(state.plants, error: e));
    }
  }
}
