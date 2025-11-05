import 'package:cloud_firestore/cloud_firestore.dart';

class AppUser {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final String? gender;
  final int? age;
  final int cigarettesPerDay;
  final int cigarettesPerPack;
  final int packPrice;
  final int yearsSmoked;
  final DateTime createdAt;
  final DateTime quitStartDate;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.age,
    this.avatarUrl,
    this.gender,
    required this.cigarettesPerDay,
    required this.cigarettesPerPack,
    required this.packPrice,
    required this.yearsSmoked,
    required this.createdAt,
    required this.quitStartDate,
  });

  factory AppUser.fromMap(String id, Map<String, dynamic> data) {
    print(
      (data['createdAt'] is Timestamp)
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
    );
    return AppUser(
      id: id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      age: data['age'],
      avatarUrl: data['avatarUrl'],
      gender: data['gender'],
      cigarettesPerDay: data['cigarettesPerDay'],
      cigarettesPerPack: data['cigarettesPerPack'],
      packPrice: data['packPrice'],
      yearsSmoked: data['yearsSmoked'],
      createdAt: (data['createdAt'] is Timestamp)
          ? (data['createdAt'] as Timestamp).toDate()
          : DateTime.now(),
      quitStartDate: (data['quitStartDate'] is Timestamp)
          ? (data['quitStartDate'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }
}
