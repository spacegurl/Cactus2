import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../core/core.dart';

class HistoryModel extends Equatable {
  const HistoryModel({
    required this.id,
    required this.plantId,
    required this.ownerId,
    required this.imageUrl,
    required this.scannedAt,
  });

  final String id;
  final String plantId;
  final String ownerId;
  final String imageUrl;
  final DateTime scannedAt;

  HistoryModel copyWith({
    String? id,
    String? plantId,
    String? ownerId,
    String? imageUrl,
    DateTime? scannedAt,
  }) {
    return HistoryModel(
      id: id ?? this.id,
      plantId: plantId ?? this.plantId,
      ownerId: ownerId ?? this.ownerId,
      imageUrl: imageUrl ?? this.imageUrl,
      scannedAt: scannedAt ?? this.scannedAt,
    );
  }

  Map<String, dynamic> toJson() => {
        FirestoreFieldKey.plantId: plantId,
        FirestoreFieldKey.ownerId: ownerId,
        FirestoreFieldKey.imageUrl: imageUrl,
        FirestoreFieldKey.scannedAt: scannedAt,
      };

  HistoryModel.fromJson(Map<String, dynamic> json)
      : id = json[FirestoreFieldKey.id],
        plantId = json[FirestoreFieldKey.plantId],
        ownerId = json[FirestoreFieldKey.ownerId],
        imageUrl = json[FirestoreFieldKey.imageUrl],
        scannedAt = json[FirestoreFieldKey.scannedAt] != null
            ? (json[FirestoreFieldKey.scannedAt] as Timestamp).toDate()
            : DateTime.now();

  @override
  List<Object> get props => [id, plantId, ownerId, imageUrl, scannedAt];
}
