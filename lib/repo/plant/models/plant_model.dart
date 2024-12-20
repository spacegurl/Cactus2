import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import '../../../core/core.dart';

class PlantModel extends Equatable {
  const PlantModel({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
  });

  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
        FirestoreFieldKey.title: title,
        FirestoreFieldKey.description: description,
        FirestoreFieldKey.imageUrl: imageUrl,
        FirestoreFieldKey.createdAt: createdAt,
      };

  PlantModel.fromJson(Map<String, dynamic> json)
      : id = json[FirestoreFieldKey.id],
        title = json[FirestoreFieldKey.title],
        description = json[FirestoreFieldKey.description],
        imageUrl = json[FirestoreFieldKey.imageUrl],
        createdAt = json[FirestoreFieldKey.createdAt] != null
            ? (json[FirestoreFieldKey.createdAt] as Timestamp).toDate()
            : DateTime.now();

  @override
  List<Object> get props => [
        id,
        title,
        description,
        imageUrl,
        createdAt,
      ];
}
