import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SOSService {
  static final _firestore = FirebaseFirestore.instance;
  static final _auth = FirebaseAuth.instance;

  /// Tăng số lần lên cơn thèm thuốc và lưu thời điểm hiện tại
  static Future<void> increaseCravingCount() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('Người dùng chưa đăng nhập');

      final userRef = _firestore.collection('users').doc(user.uid);
      final userSnap = await userRef.get();

      final now = Timestamp.now();

      if (userSnap.exists) {
        final currentCount = userSnap.data()?['cravingCount'] ?? 0;

        await userRef.update({
          'cravingCount': currentCount + 1,
          'lastCravingAt': now,
          'cravingHistory': FieldValue.arrayUnion([now]),
        });
      } else {
        await userRef.set({
          'cravingCount': 1,
          'lastCravingAt': now,
          'cravingHistory': [now],
        });
      }
    } catch (e) {
      rethrow;
    }
  }

  /// Lấy tổng số lần thèm thuốc
  static Future<int> getCravingCount() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('Người dùng chưa đăng nhập');

      final userSnap = await _firestore.collection('users').doc(user.uid).get();

      if (!userSnap.exists) return 0;
      return userSnap.data()?['cravingCount'] ?? 0;
    } catch (e) {
      rethrow;
    }
  }

  /// Lấy danh sách thời điểm thèm thuốc
  static Future<List<DateTime>> getCravingHistory() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('Người dùng chưa đăng nhập');

      final userSnap = await _firestore.collection('users').doc(user.uid).get();
      if (!userSnap.exists) return [];

      final history = userSnap.data()?['cravingHistory'] ?? [];
      final timestamps = List<Timestamp>.from(history);
      return timestamps.map((e) => e.toDate()).toList();
    } catch (e) {
      rethrow;
    }
  }

  /// Reset toàn bộ thống kê
  static Future<void> resetCravingCount() async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('Người dùng chưa đăng nhập');

      await _firestore.collection('users').doc(user.uid).update({
        'cravingCount': 0,
        'cravingHistory': [],
      });
    } catch (e) {
      rethrow;
    }
  }
}
