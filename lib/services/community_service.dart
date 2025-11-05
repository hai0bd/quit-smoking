import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quit_smoking/models/community_post_model.dart';

class CommunityService {
  static final _firestore = FirebaseFirestore.instance;
  static final _collection = _firestore.collection('community_posts');
  static final _auth = FirebaseAuth.instance;

  static Future<void> addPost(String message) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    await _collection.add({
      'userId': user.uid,
      'userName': user.displayName ?? user.email?.split('@')[0] ?? 'Người dùng',
      'message': message,
      'createdAt': FieldValue.serverTimestamp(),
      'likes': <String>[],
    });
  }

  static Stream<List<CommunityPostModel>> getPosts() {
    return _collection.orderBy('createdAt', descending: true).snapshots().map((
      snapshot,
    ) {
      return snapshot.docs
          .map((doc) => CommunityPostModel.fromFirestore(doc))
          .toList();
    });
  }

  static Future<void> likePost(String postId) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final ref = _collection.doc(postId);
    await ref.update({
      'likes': FieldValue.arrayUnion([user.uid]),
    });
  }

  static Future<void> unlikePost(String postId) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('User not logged in');

    final ref = _collection.doc(postId);
    await ref.update({
      'likes': FieldValue.arrayRemove([user.uid]),
    });
  }

  static Future<bool> isPostLiked(String postId) async {
    final user = _auth.currentUser;
    if (user == null) return false;

    final snapshot = await _collection.doc(postId).get();
    final data = snapshot.data();
    if (data == null) return false;

    final likes = List<String>.from(data['likes'] ?? []);
    return likes.contains(user.uid);
  }

  static Stream<int> likeCountStream(String postId) {
    return _collection.doc(postId).snapshots().map((snapshot) {
      final data = snapshot.data();
      if (data == null) return 0;
      final likes = List<String>.from(data['likes'] ?? []);
      return likes.length;
    });
  }

  static Future<int> getTotalPostCount() async {
    try {
      final snapshot = await _collection.get();
      return snapshot.size;
    } catch (e) {
      return 0;
    }
  }

  static Future<int> getTotalLikeCount() async {
    try {
      final snapshot = await _collection.get();
      int totalLikes = 0;
      for (var doc in snapshot.docs) {
        final likes = List<String>.from(doc.data()['likes'] ?? []);
        totalLikes += likes.length;
      }
      return totalLikes;
    } catch (e) {
      return 0;
    }
  }
}
