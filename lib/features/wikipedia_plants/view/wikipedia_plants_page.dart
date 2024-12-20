import 'package:cactus/core/core.dart';
import 'package:cactus/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/wikipedia_plants_bloc.dart';

class WikipediaPlantsPage extends StatelessWidget {
  const WikipediaPlantsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AuthAccessWrapped(
      child: BlocConsumer<WikipediaPlantsBloc, WikipediaPlantsState>(
        listener: (context, state) {
          if (state is WikipediaPlantsFailure) {
            UiUtils.showSnackBar(
              context,
              ExceptionUtils.clearMessage(state.error),
              color: Colors.red,
            );
            return;
          }
        },
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              context.read<WikipediaPlantsBloc>().add(WikipediaPlantsFetched());
            },
            child: state is WikipediaPlantsLoading
                ? const Center(child: CircularProgressIndicator())
                : state.plants.isEmpty
                    ? ListView(
                        children: [
                          Center(
                            child: Text(
                              'Ещё не добавлено ни одного растения',
                              style: theme.textTheme.titleMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemBuilder: (ctx, i) {
                          final plant = state.plants[i];

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20)
                                .copyWith(bottom: i == 10 - 1 ? 0 : 15),
                            child: PlantCard(plant: plant),
                          );
                        },
                        itemCount: state.plants.length,
                      ),
          );
        },
      ),
    );
  }
}
