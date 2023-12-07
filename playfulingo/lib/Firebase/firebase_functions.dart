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

