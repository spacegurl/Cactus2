import 'package:cactus/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/core.dart';
import 'features/features.dart';

class CactusApp extends StatelessWidget {
  const CactusApp({
    super.key,
    required AuthRepo authRepo,
    required PlantRepo plantRepo,
    required HistoryRepo historyRepo,
  })  : _historyRepo = historyRepo,
        _plantRepo = plantRepo,
        _authRepo = authRepo;

  final AuthRepo _authRepo;
  final PlantRepo _plantRepo;
  final HistoryRepo _historyRepo;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _plantRepo),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AuthBloc(authRepo: _authRepo)),
          BlocProvider(
            create: (_) => WikipediaPlantsBloc(plantRepo: _plantRepo),
          ),
          BlocProvider(create: (_) => HistoryBloc(historyRepo: _historyRepo)),
        ],
        child: MaterialApp(
          title: 'Cactus 2.0',
          theme: themeData,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRouter.generateRoute,
        ),
      ),
    );
  }
}
