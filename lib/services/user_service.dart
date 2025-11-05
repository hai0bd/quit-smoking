import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quit_smoking/models/app_user.dart';
import 'package:quit_smoking/services/date_counter_service.dart';
import 'package:http/http.dart' as http;

class UserService {
  static final _auth = FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;
  static final _collection = _firestore.collection('users');

  static Future<DateTime?> getUserQuitDate() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      final doc = await _collection.doc(user.uid).get();

      if (!doc.exists) return null;

      final data = doc.data();
      if (data == null || !data.containsKey('quitStartDate')) return null;

      final timestamp = data['quitStartDate'];
      return DateCounterService.fromTimestamp(timestamp);
    } catch (e) {
      return null;
    }
  }

  static Future<int> getTotalUserCount() async {
    try {
      final snapshot = await _collection.get();
      return snapshot.size;
    } catch (e) {
      return 0;
    }
  }

  static Future<AppUser?> getCurrentUserInfo() async {
    try {
      final user = _auth.currentUser;
      if (user == null) return null;

      final doc = await _collection.doc(user.uid).get();
      if (!doc.exists) return null;

      return AppUser.fromMap(doc.id, doc.data() ?? {});
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> uploadAvatarToCloudinary(File imageFile) async {
    const cloudName = 'dgfmiwien';
    const uploadPreset = 'sneakers';

    final uri = Uri.parse(
      "https://api.cloudinary.com/v1_1/$cloudName/image/upload",
    );
    final request = http.MultipartRequest("POST", uri)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    final response = await request.send();
    final resBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final data = jsonDecode(resBody);
      return data['secure_url'];
    } else {
      throw Exception("Tải ảnh lên Cloudinary thất bại");
    }
  }

  /// 🔄 Cập nhật thông tin người dùng
  static Future<void> updateUserInfo({
    required String name,
    required String gender,
    required int age,
    String? avatarUrl,
  }) async {
    try {
      final user = _auth.currentUser;
      if (user == null) throw Exception('Người dùng chưa đăng nhập');

      final updateData = {'name': name, 'gender': gender, 'age': age};

      if (avatarUrl != null) {
        updateData['avatarUrl'] = avatarUrl;
      }

      await _firestore.collection('users').doc(user.uid).update(updateData);
    } catch (e) {
      rethrow;
    }
  }
}
