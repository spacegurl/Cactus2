import 'dart:io';

import 'package:cactus/repo/repo.dart';
import 'package:flutter/material.dart';
import '../../features/features.dart';
import '../core.dart';

//Роутер с настройков всех маршрутов
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    try {
      //Аргументы, которые мы можем передавать переходя на страницу
      final arguments = settings.arguments;

      //Относительно переданного имени загружаем страницу
      switch (settings.name) {
        case RouteNames.root:
          return MaterialPageRoute(builder: (_) => const RootScreen());
        case RouteNames.login:
          return MaterialPageRoute(builder: (_) => const LoginScreen());
        case RouteNames.register:
          return MaterialPageRoute(builder: (_) => const RegisterScreen());
        case RouteNames.plantDetail:
          final args = arguments as Map<dynamic, dynamic>;

          final scannedFile = args['scannedFile'] as File?;
          final plant = args['plant'] as PlantModel?;
          final history = args['history'] as HistoryModel?;

          return MaterialPageRoute(
            fullscreenDialog: scannedFile != null,
            builder: (_) => PlantDetailScreen(
              scannedFile: scannedFile,
              plant: plant,
              history: history,
            ),
          );
        default:
          return _errorRoute();
      }
    } catch (e) {
      return _errorRoute();
    }
  }

  //Страница-ошибка
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('Возникла ошибка при переходе на страницу!'),
          ),
        );
      },
    );
  }
}
