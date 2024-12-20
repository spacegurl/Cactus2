import 'package:cactus/repo/repo.dart';
import 'package:cactus/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/core.dart';

class PlantCard extends StatelessWidget {
  const PlantCard({super.key, required this.plant, this.history});

  final HistoryModel? history;
  final PlantModel? plant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      child: InkWell(
        onTap: plant == null
            ? null
            : () {
                Navigator.of(context).pushNamed(
                  RouteNames.plantDetail,
                  arguments: {
                    'plant': plant,
                    'history': history,
                  },
                );
              },
        borderRadius: BorderRadius.circular(10),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (plant != null)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PlantImage(
                      imageUrl:
                          history != null ? history!.imageUrl : plant!.imageUrl,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            plant!.title,
                            style: theme.textTheme.bodyLarge,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            plant!.description,
                            style: theme.textTheme.bodyMedium!.copyWith(
                              color: AppColors.kDescriptionColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              else
                Text(
                  'Не найдено растение в базе',
                  style: theme.textTheme.bodyLarge,
                ),
              if (history != null) ...[
                const Divider(color: AppColors.kDividerColor),
                Center(
                  child: Text(
                    'Скан в ${DateFormat('HH:mm dd.MM.yyyy').format(history!.scannedAt)}',
                    style: theme.textTheme.bodySmall!.copyWith(
                      color: AppColors.kPrimaryColor,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
