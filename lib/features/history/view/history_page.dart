import 'package:cactus/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/core.dart';
import '../../features.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AuthAccessWrapped(
      child: BlocConsumer<HistoryBloc, HistoryState>(
        listener: (context, state) {
          if (state is HistoryFailure) {
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
              context.read<HistoryBloc>().add(HistoryFetched());
            },
            child: state is HistoryLoading
                ? const Center(child: CircularProgressIndicator())
                : BlocBuilder<WikipediaPlantsBloc, WikipediaPlantsState>(
                    builder: (context, wikipediaState) {
                      if (state.historyList.isEmpty) {
                        return ListView(
                          children: [
                            Center(
                              child: Text(
                                'Ваш список историй сканов пуст',
                                style: theme.textTheme.titleMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        );
                      }

                      return ListView.builder(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemBuilder: (ctx, i) {
                          final history = state.historyList[i];
                          final plant = wikipediaState.plants
                              .where((e) => e.id == history.plantId)
                              .firstOrNull;

                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20)
                                .copyWith(bottom: i == 10 - 1 ? 0 : 15),
                            child: PlantCard(plant: plant, history: history),
                          );
                        },
                        itemCount: state.historyList.length,
                      );
                    },
                  ),
          );
        },
      ),
    );
  }
}
