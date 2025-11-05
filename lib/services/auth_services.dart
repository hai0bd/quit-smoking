import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quit_smoking/configs/constant.dart';
import 'package:quit_smoking/presentation/authentication/login_page.dart';
import 'package:quit_smoking/services/dialog_service.dart';
import 'package:quit_smoking/services/local_storage.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<User?> signUp({
    required String email,
    required String password,
    required String name,
    required int cigarettesPerDay,
    required int cigarettesPerPack,
    required int packPrice,
    required int yearsSmoked,
  }) async {
    try {
      // Tạo tài khoản trong Firebase Auth
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = result.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'uid': user.uid,
          'name': name,
          'email': email,
          'createdAt': FieldValue.serverTimestamp(),
          'quitStartDate': FieldValue.serverTimestamp(),
          'cigarettesPerDay': cigarettesPerDay,
          'cigarettesPerPack': cigarettesPerPack,
          'packPrice': packPrice,
          'yearsSmoked': yearsSmoked,
          'goals': [],
        });
      }

      return user;
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  /// Đăng nhập
  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (_) {
      rethrow;
    }
  }

  /// Đăng xuất
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    await LocalStorage.remove(kNotification);
    if (context.mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  static Future<bool> checkEmailExists(String email) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    final query = await firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .limit(1)
        .get();

    return query.docs.isNotEmpty;
  }

  Future<void> resetPassword(BuildContext context, String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      if (context.mounted) {
        await DialogService.showSuccess(
          context,
          'Thành công',
          'Liên kết đặt lại mật khẩu đã được gửi tới email của bạn.',
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = 'Đã có lỗi xảy ra.';

      if (e.code == 'user-not-found') {
        message = 'Email này chưa được đăng ký.';
      } else if (e.code == 'invalid-email') {
        message = 'Email không hợp lệ.';
      }

      if (context.mounted) {
        await DialogService.showError(context, 'Lỗi đăng nhập', message);
      }
    }
  }

  /// Lấy user hiện tại
  User? get currentUser => _auth.currentUser;

  /// Stream theo dõi trạng thái đăng nhập
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}
