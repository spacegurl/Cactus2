import 'dart:math';

import 'package:cactus/repo/repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/core.dart';

class PlantRepo {
  const PlantRepo({required FirebaseFirestore firestore})
      : _firestore = firestore;
  final FirebaseFirestore _firestore;

  Future<List<PlantModel>> getPlants() async {
    final plants = <PlantModel>[];

    final snapshot =
        await _firestore.collection(FirestoreCollectionKey.plants).get();

    if (snapshot.docs.isEmpty) return plants;

    for (var doc in snapshot.docs) {
      final json = doc.data();
      json[FirestoreFieldKey.id] = doc.id;

      plants.add(PlantModel.fromJson(json));
    }

    return plants;
  }

  Future<PlantModel?> getScannedPlant() async {
    final snapshot =
        await _firestore.collection(FirestoreCollectionKey.plants).get();

    if (snapshot.docs.isEmpty) return null;

    final random = Random();
    final doc = snapshot.docs[random.nextInt(snapshot.docs.length)];

    final json = doc.data();
    json[FirestoreFieldKey.id] = doc.id;

    return PlantModel.fromJson(json);
  }
}
