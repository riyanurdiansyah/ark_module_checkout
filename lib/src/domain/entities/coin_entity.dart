import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class CoinEntity extends Equatable {
  const CoinEntity({
    required this.coins,
    required this.isCompleted,
    required this.createdAt,
    required this.updatedAt,
    required this.isOldUser,
  });

  final int coins;
  final bool isCompleted;
  final Timestamp createdAt;
  final Timestamp updatedAt;
  final bool isOldUser;

  @override
  List<Object?> get props =>
      [coins, isCompleted, createdAt, updatedAt, isOldUser];
}
