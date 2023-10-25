import 'package:Eventlyst/pages/My_Drawer_List.dart';
import 'package:Eventlyst/pages/My_Drawer_Header.dart';
import 'package:Eventlyst/pages/post_page.dart';
import 'package:Eventlyst/utils/routes.dart';
import 'package:Eventlyst/widdget/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:Eventlyst/pages/post.dart';

// import 'bnav.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String username = ''; // Initialize with an empty string
  String email = ''; // Initialize with an empty string
  // Retrieve user data from arguments
  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    // Retrieve user data from arguments
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args != null) {
      final DocumentSnapshot userDoc = args['userDoc'];
      setState(() {
        username = userDoc['username'];
        email = userDoc['email'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final DocumentSnapshot? userDoc = args?['userDoc'];

    if (userDoc != null) {
      // Now, you can access and use the 'userDoc' data in this page.
      // ...
    }
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press as needed
        // Return 'true' to allow the back navigation, or 'false' to block it
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Eventlyst"),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.remRoute);
              },
              icon: const Icon(Icons.notifications_none_sharp),
            ),
          ],
        ),

        drawer: Drawer(
          child: SingleChildScrollView(
            child: Container(
              child: Column(
                children: [
                  MyHeaderDrawer(), // Pass username and email
                  SizedBox(height: MediaQuery.of(context).size.height * 0.45),
                  MyDrawerList(),
                ],
              ),
            ),
          ),
        ),
// Post Interface
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                //SizedBox(height: 20.0),
                // Text("Username: ${userDoc?.get('username') ?? 'N/A'}"),
                // Text("Email: ${userDoc?.get('email') ?? 'N/A'}"),
                MyPost(),
                SizedBox(height: 1.0),
                MyPost(),
              ],
            ),
          ),
        ),
        // Navigation bar
        bottomNavigationBar: Container(
          height: (MediaQuery.of(context).size.height * 0.1),
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: GNav(
              gap: 12,
              // backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.black,
              tabs: [
                GButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      MyRoutes.homeRoute,
                    );
                  },
                  icon: Icons.home,
                ),
                GButton(
                  onPressed: () {
                    Navigator.pushNamed(context, MyRoutes.searchRoute);
                  },
                  icon: Icons.search,
                ),
                GButton(
                  onPressed: () {
                    Navigator.pushNamed(context, MyRoutes.postRoute);
                  },
                  icon: Icons.post_add,
                ),
                GButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      MyRoutes.orgRoute,
                    );
                  },
                  icon: Icons.school,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
