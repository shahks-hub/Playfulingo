import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProgressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title: Text(
          'Progress Report',
          style: TextStyle(
            color: Colors.white,
            fontSize: 30.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.purple[200],
      ),
      body: FutureBuilder<User?>(
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('User not authenticated'));
          } else {
            final currentUser = FirebaseAuth.instance.currentUser!;
            final userRef = FirebaseFirestore.instance
                .collection('users')
                .doc(currentUser.uid);

            return StreamBuilder<DocumentSnapshot>(
              stream: userRef.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || !snapshot.data!.exists) {
                  return Center(child: Text('User data not found'));
                } else {
                  final userData = snapshot.data!;
                  final completedLessons = List<String>.from(
                      userData.get('completed_lessons') ?? []);

                  return FutureBuilder<QuerySnapshot>(
                    future: userRef.collection('game_scores').get(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData ||
                          snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('No game scores available'));
                      } else {
                        final gameScores = snapshot.data!.docs;

                        return SingleChildScrollView(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildSectionTitle(
                                  'Completed Lessons', Colors.purple),
                              SizedBox(height: 10),
                              _buildBoxList(
                                  completedLessons, Colors.purple[800]!),
                              SizedBox(height: 80),
                              _buildSectionTitle('Game Scores', Colors.purple),
                              SizedBox(height: 10),
                              _buildBoxList(
                                gameScores
                                    .map((gameEntry) =>
                                        'Game: ${gameEntry.id}, Highest Score Earned: ${gameEntry['highest_score']}')
                                    .toList(),
                                Colors.purple[800]!,
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  );
                }
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildSectionTitle(String title, Color color) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: color,
      ),
    );
  }

  Widget _buildBoxList(List<String> items, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.isNotEmpty
          ? items
              .map((item) => Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ))
              .toList()
          : [
              Text('No items, Come back after taking some lessons!',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ))
            ],
    );
  }
}
