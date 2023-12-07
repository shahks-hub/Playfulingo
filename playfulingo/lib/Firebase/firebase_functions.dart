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
      completedLessons.addAll(completedLessonsRefs.map((ref) => ref.toString()));
    }

    print("completed: $completedLessons");
    return completedLessons;
  } catch (e) {
    print('Error fetching completed lessons: $e');
    return [];
  }
}


// Future<void> updateGameScore(String userId, String gameName, int newScore) async {
//   final userRef = FirebaseFirestore.instance.collection('users').doc(userId)
//       .collection('game_scores').doc(gameName);

//   // Get the existing highest score for this game
//   final snapshot = await userRef.get();
//   if (snapshot.exists) {
//     final currentHighestScore = snapshot.data()?['highest_score'] ?? 0;
//     if (newScore > currentHighestScore) {
//       // Update the highest score if the new score is higher
//       await userRef.set({'highest_score': newScore});
//       print('Highest score for $gameName updated to $newScore');
//     }
//   } else {
//     // If the game document doesn't exist, create it with the new score
//     await userRef.set({'highest_score': newScore});
//     print('New game added: $gameName with score $newScore');
//   }
// }

// // Usage:
// updateGameScore('user_id_here', 'game_1', 120); // Example usage to update game score
