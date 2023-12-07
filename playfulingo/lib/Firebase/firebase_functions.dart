import 'package:cloud_firestore/cloud_firestore.dart';

Future<List<String>> fetchCompletedLessons(String userEmail) async {
  final db = FirebaseFirestore.instance;
  try {
    final userSnapshot = await db.collection("users")
        .where('email', isEqualTo: userEmail)
        .limit(1)
        .get();
   
    List<String> completedLessons = [];
    //  print(userSnapshot.docs);
    if (userSnapshot.docs.isNotEmpty) {
      final userData = userSnapshot.docs.first.data();
      //  print("user data: $userData ");
      List<dynamic> completedLessonsRefs = userData['completed_lessons'] ?? [];

      // Ensure that elements are casted to strings
      completedLessons.addAll(completedLessonsRefs.map((ref) => ref.id.toString()));
    }
    // print("completed: $completedLessons");
    return completedLessons;
  } catch (e) {
    print('Error fetching completed lessons: $e');
    return [];
  }
}
