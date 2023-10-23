import 'package:Eventlyst/utils/routes.dart';
import 'package:flutter/material.dart';

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
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.loginRoute);
            },
            child: Text(
              "Sign Out",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: MediaQuery.of(context).size.width * 0.06,
              ),
            ),
          )),
        ],
      ),
    );
  }
}
