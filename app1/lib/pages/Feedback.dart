import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Myfeedback extends StatefulWidget {
  const Myfeedback({Key? key});

  @override
  State<Myfeedback> createState() => _MyfeedbackState();
}

class _MyfeedbackState extends State<Myfeedback> {
  TextEditingController feedbackController = TextEditingController();

  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  Future<void> uploadFeedbackToFirestore(String feedback) async {
    try {
      User? currentUser = await getCurrentUser();

      if (currentUser != null) {
        // Store feedback
        await FirebaseFirestore.instance.collection('feedback').add({
          'feedback': feedback,
          'user_id': currentUser.uid,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Feedback submitted successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {}
    } catch (e) {
      print('Error submitting feedback: $e');
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to submit feedback'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Share Your Feedback',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextField(
              controller: feedbackController,
              decoration: InputDecoration(
                labelText: 'Your Feedback',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                String feedback = feedbackController.text;
                if (feedback.isNotEmpty) {
                  uploadFeedbackToFirestore(feedback);
                  feedbackController.clear();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Please enter feedback before submitting'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                elevation: 4.0,
              ),
              child: Text(
                'Submit Feedback',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
