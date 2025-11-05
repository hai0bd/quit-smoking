import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quit_smoking/models/emotion_model.dart';

class EmotionService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;

  /// Thêm cảm xúc mới
  static Future<void> addEmotion({
    required String content,
    required String typeEmotion,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User chưa đăng nhập');

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('emotions')
          .add({
            'content': content,
            'typeEmotion': typeEmotion,
            'createdAt': DateTime.now(),
          });
    } catch (e) {
      rethrow;
    }
  }

  /// Lấy danh sách cảm xúc của user, sắp xếp mới nhất trước
  static Stream<List<EmotionModel>> getUserEmotions() {
    final user = _auth.currentUser;
    if (user == null) {
      return const Stream.empty();
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('emotions')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs.map((doc) {
            return EmotionModel.fromDocument(doc);
          }).toList(),
        );
  }

  /// Xoá một cảm xúc theo id
  static Future<void> deleteEmotion(String docId) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('User chưa đăng nhập');

      await _firestore
          .collection('users')
          .doc(user.uid)
          .collection('emotions')
          .doc(docId)
          .delete();
    } catch (e) {
      rethrow;
    }
  }
}
