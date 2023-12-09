import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<List<String>> fetchCompletedLessons(String userEmail) async {
  final db = FirebaseFirestore.instance;
  try {
    final userSnapshot = await db
        .collection("users")
        .where('email', isEqualTo: userEmail)
        .limit(1)
        .get();

    List<String> completedLessons = [];

    if (userSnapshot.docs.isNotEmpty) {
      final userData = userSnapshot.docs.first.data();
      print("user data: $userData ");

      // Assuming completed_lessons is a list of strings
      List<dynamic> completedLessonsRefs = userData['completed_lessons'] ?? [];

      // No need for mapping if they are directly strings
      completedLessons
          .addAll(completedLessonsRefs.map((ref) => ref.toString()));
    }

    print("completed: $completedLessons");
    return completedLessons;
  } catch (e) {
    print('Error fetching completed lessons: $e');
    return [];
  }
}

Future<int> getCurrentHighestScore(String gameName) async {
  final currentUser = FirebaseAuth.instance.currentUser;

  final userRef = FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser?.uid)
      .collection('game_scores')
      .doc(gameName);

  try {
    final snapshot = await userRef.get();

    if (snapshot.exists) {
      return snapshot.data()?['highest_score'] ?? 0;
    }
    return 0; // Return 0 if the document doesn't exist
  } catch (e) {
    print('Error fetching current highest score: $e');
    throw e; // Handle the error accordingly
  }
}

Future<void> updateGameScore(String gameName, int newScore) async {
  try {
    final currentHighestScore = await getCurrentHighestScore(gameName);

    if (newScore > currentHighestScore) {
      final currentUser = FirebaseAuth.instance.currentUser;

      final userRef = FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser?.uid)
          .collection('game_scores')
          .doc(gameName);

      await userRef.set({'highest_score': newScore});
      print('Highest score for $gameName updated to $newScore');
    }
  } catch (e) {
    print('Error updating game score: $e');
    // Handle error accordingly
  }
}

