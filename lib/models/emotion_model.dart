import 'package:cloud_firestore/cloud_firestore.dart';

class EmotionModel {
  final String id;
  final String content;
  final String typeEmotion;
  final DateTime createdAt;

  EmotionModel({
    required this.id,
    required this.content,
    required this.typeEmotion,
    required this.createdAt,
  });

  factory EmotionModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return EmotionModel(
      id: doc.id,
      content: data['content'] ?? '',
      typeEmotion: data['typeEmotion'] ?? '',
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'content': content,
      'typeEmotion': typeEmotion,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }
}
