import 'dart:io';

import 'package:cactus/core/core.dart';
import 'package:cactus/features/features.dart';
import 'package:cactus/repo/repo.dart';
import 'package:cactus/ui/ui.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PlantDetailScreen extends StatelessWidget {
  const PlantDetailScreen({
    super.key,
    required this.scannedFile,
    this.plant,
    this.history,
  });

  final File? scannedFile;
  final PlantModel? plant;
  final HistoryModel? history;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    String? imageUrl;

    if (history != null) {
      imageUrl = history!.imageUrl;
    } else {
      imageUrl = plant!.imageUrl;
    }

    return Scaffold(
      appBar: AppBar(
        title:
            Text(scannedFile != null ? 'Результат скана' : 'Детали растения'),
        leading: scannedFile != null
            ? IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: scannedFile != null
                    ? PlantImage.file(file: scannedFile!, size: 200)
                    : PlantImage.url(imageUrl: imageUrl, size: 200),
              ),
              const SizedBox(height: 30),
              if (plant != null)
                Column(
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
                )
              else
                Text(
                  'Не найдено растение в базе',
                  style: theme.textTheme.bodyLarge,
                ),
              if (history != null) ...[
                const SizedBox(height: 3),
                Text(
                  'Скан в ${DateFormat('HH:mm dd.MM.yyyy').format(history!.scannedAt)}',
                  style: theme.textTheme.bodyMedium!
                      .copyWith(color: AppColors.kPrimaryColor),
                ),
              ],
              if (scannedFile != null)
                SaveHistoryButton(
                  scannedFile: scannedFile!,
                  plant: plant,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
