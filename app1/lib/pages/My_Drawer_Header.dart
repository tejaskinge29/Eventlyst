import 'package:Eventlyst/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyHeaderDrawer());
}

Future<void> fetch_DataFromFirestore() async {
  try {
    // Get a reference to the Firestore instance
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    // Get a reference to a specific collection
    final CollectionReference usersCollection = firestore.collection('users');

    // Get a specific document by its ID (e.g., the user's UID)
    DocumentSnapshot userDoc = await usersCollection.doc('user_uid_here').get();

    if (userDoc.exists) {
      // Document exists, you can access its data
      String username = userDoc['username'];
      String email = userDoc['email'];

      print('Username: $username');
      print('Email: $email');
    } else {
      print('Document does not exist.');
    }
  } catch (e) {
    print('Error fetching data: $e');
  }
}

class MyHeaderDrawer extends StatelessWidget {
  //  final String username;
  // final String email;

  // MyHeaderDrawer({required this.username, required this.email});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: fetchDataFromFirestore(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final userDoc = snapshot.data;
            final userData = userDoc?.data(); // Access data as a Map

            if (userData != null && userData is Map<String, dynamic>) {
              final username = userData['username'] as String?;
              final email = userData['email'] as String?;
              return Container(
                color: Colors.black,
                width: double.infinity,
                height: 200,
                padding: EdgeInsets.only(top: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 0),
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/profilew.png'),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, MyRoutes.profileRoute);
                      },
                      child: Text(
                        username ?? '', // Display username when available
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: MediaQuery.of(context).size.width * 0.04,
                        ),
                      ),
                    ),
                    Text(
                      email ?? '', // Display email when available
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Container(); // Handle the case where data is not available
            }
          } else {
            return Container(); // Handle the case where data is not available
          }
        } else {
          // Instead of returning CircularProgressIndicator, return an empty Container
          return Container();
        }
      },
    );
  }
}

// Future<void> fetchUserData() async {
//   // Retrieve user data from arguments
//   final Map<String, dynamic>? args =
//       ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

//   if (args != null) {
//     final DocumentSnapshot userDoc = args['userDoc'];
//     setState(() {
//       username = userDoc['username'];
//       email = userDoc['email'];
//       print('Username: $username');
//       print('Email: $email');
//     });
//   }
// }

Future<DocumentSnapshot> fetchDataFromFirestore() async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference usersCollection = firestore.collection('users');
  final DocumentSnapshot userDoc =
      await usersCollection.doc('user_uid_here').get();
  return userDoc;
}
