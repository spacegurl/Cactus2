import 'package:cactus/repo/repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../core/core.dart';

class HistoryRepo {
  const HistoryRepo({required FirebaseFirestore firestore})
      : _firestore = firestore;
  final FirebaseFirestore _firestore;

  Future<List<HistoryModel>> getHistory() async {
    final user = FirebaseAuth.instance.currentUser!;
    final plants = <HistoryModel>[];

    final snapshot = await _firestore
        .collection(FirestoreCollectionKey.history)
        .where(FirestoreFieldKey.ownerId, isEqualTo: user.uid)
        .get();

    if (snapshot.docs.isEmpty) return plants;

    for (var doc in snapshot.docs) {
      final json = doc.data();
      json[FirestoreFieldKey.id] = doc.id;

      plants.add(HistoryModel.fromJson(json));
    }

    return plants;
  }

  Future<HistoryModel> createHistory(HistoryModel history) async {
    final newHistory = await _firestore
        .collection(FirestoreCollectionKey.history)
        .add(history.toJson());

    return history.copyWith(id: newHistory.id);
  }
}
