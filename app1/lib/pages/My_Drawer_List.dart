import 'package:Eventlyst/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:Eventlyst/pages/auth_service/auth_service.dart';

class MyDrawerList extends StatefulWidget {
  const MyDrawerList({super.key});

  @override
  State<MyDrawerList> createState() => _MyDrawerListState();
}

class _MyDrawerListState extends State<MyDrawerList> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // SizedBox(height: MediaQuery.of(context).size.height * 0.45),
          ListTile(
              title: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.BookmarkRoute);
            },
            child: Text(
              "Bookmark",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.06,
              ),
            ),
          )),
          ListTile(
              title: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.FeedbackRoute);
            },
            child: Text(
              "Feedback",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.06,
              ),
            ),
          )),
          ListTile(
              title: TextButton(
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.settingRoute);
            },
            child: Text(
              "Settings",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.06,
              ),
            ),
          )),
          ListTile(
            title: TextButton(
              onPressed: () async {
                try {
                  // Perform the Firebase logout logic
                  await FirebaseAuth.instance.signOut();

                  // Update SharedPreferences to reflect that the user is logged out
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('isLoggedIn', false);

                  // Navigate to the login page
                  Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
                } catch (e) {
                  print("Error during logout: $e");
                }
              },
              child: Text(
                "Sign Out",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
