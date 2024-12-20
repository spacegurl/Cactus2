import 'package:cactus/app.dart';
import 'package:cactus/repo/repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'firebase_options.dart';
import 'generated/assets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  const logo = SvgAssetLoader(Assets.assetsLogo);
  await svg.cache.putIfAbsent(logo.cacheKey(null), () => logo.loadBytes(null));

  //Получение firestore
  final firestore = FirebaseFirestore.instance;

  //Создание репозиториев
  final authRepo = AuthRepo();
  final plantRepo = PlantRepo(firestore: firestore);
  final historyRepo = HistoryRepo(firestore: firestore);

  runApp(CactusApp(
    authRepo: authRepo,
    plantRepo: plantRepo,
    historyRepo: historyRepo,
  ));
}
