import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Save skill test score
  Future<void> saveSkillScore(int score, int totalQuestions) async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return;

    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();

    await _db.collection('users')
        .doc(uid)
        .collection('skills')
        .doc(timestamp)
        .set({
      'score': score,
      'total': totalQuestions,
      'date': DateTime.now(),
    });
  }

  /// Load past scores
  Future<List<int>> getPastScores() async {
    final uid = _auth.currentUser?.uid;
    if (uid == null) return [];

    final snapshot = await _db.collection('users')
        .doc(uid)
        .collection('skills')
        .orderBy('date', descending: true)
        .get();

    return snapshot.docs.map((doc) => doc['score'] as int).toList();
  }
}
