import 'dart:io';
import 'package:flutter/material.dart';

import '../../generated/assets.dart';

class PlantImage extends StatelessWidget {
  const PlantImage({
    super.key,
    this.file,
    this.imageUrl,
    this.size = 50,
  });

  const PlantImage.url({
    super.key,
    required this.imageUrl,
    this.file,
    this.size = 50,
  });

  const PlantImage.file({
    super.key,
    required this.file,
    this.imageUrl,
    this.size = 200,
  });

  final String? imageUrl;
  final File? file;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: _getImageProvider(),
          //Если ошибка, показываем шаблон
          onError: (error, stackTrace) =>
              const AssetImage(Assets.assetsSadLogo),
          //Обрезка фото, чтобы смотрелось хорошо
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  ImageProvider<Object> _getImageProvider() {
    if (file != null) {
      return FileImage(file!);
    }

    if ((imageUrl ?? '').isNotEmpty) {
      return NetworkImage(imageUrl!);
    }

    return const AssetImage(Assets.assetsSadLogo);
  }
}
