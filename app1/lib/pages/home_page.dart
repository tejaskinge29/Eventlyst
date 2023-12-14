import 'package:Eventlyst/pages/My_Drawer_List.dart';
import 'package:Eventlyst/pages/My_Drawer_Header.dart';
import 'package:Eventlyst/pages/post_page.dart';
import 'package:Eventlyst/utils/routes.dart';
import 'package:Eventlyst/widdget/drawer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:Eventlyst/pages/post.dart';
import 'package:badges/badges.dart';
import 'package:Eventlyst/user_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:Eventlyst/pages/login_page.dart';
import 'package:Eventlyst/pages/FirestorePostDisplay.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'bnav.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? currentBackPressTime;
  String username = ''; // Initialize with an empty string
  String email = ''; // Initialize with an empty string
  // Retrieve user data from arguments
  @override
  void initState() {
    super.initState();
    checkLoginState();
    fetchUserData();
  }

  Future<void> checkLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!isLoggedIn) {
      // If not logged in, navigate to the login page
      Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
    }
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
    SharedPreferences prefs = Provider.of<SharedPreferences>(context);

    // Check if the user is logged in
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (!isLoggedIn) {
      // If not logged in, navigate to login page
      Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
    }
    // Access the user ID from the provider
    String userId = Provider.of<UserIdProvider>(context).userId;

    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final DocumentSnapshot? userDoc = args?['userDoc'];

    if (userDoc != null) {
      // Now, you can access and use the 'userDoc' data in this page.
      // ...
    }
    return WillPopScope(
      onWillPop: () async {
        DateTime now = DateTime.now();
        if (currentBackPressTime == null ||
            now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
          // Show a toast or snackbar indicating that another press is required
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Press again to exit'),
              duration: Duration(seconds: 2),
            ),
          );
          currentBackPressTime = now;
          return false;
        }
        return true; // Allow the app to exit
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
              icon: Stack(
                children: [
                  Icon(Icons.notifications_none_sharp),
                  // Consumer<NotificationProvider>(
                  //   builder: (context, notificationProvider, child) {
                  //     if (notificationProvider.notificationCount > 0) {
                  //       return Positioned(
                  //         right: 0,
                  //         top: 0,
                  //         child: Container(
                  //           padding: EdgeInsets.all(2),
                  //           decoration: BoxDecoration(
                  //             color: Colors.red,
                  //             shape: BoxShape.circle,
                  //           ),
                  //           constraints: BoxConstraints(
                  //             minWidth: 16,
                  //             minHeight: 16,
                  //           ),
                  //           child: Center(
                  //             child: Text(
                  //               notificationProvider.notificationCount
                  //                   .toString(),
                  //               style: TextStyle(
                  //                 color: Colors.white,
                  //                 fontSize: 12,
                  //               ),
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     } else {
                  //       return SizedBox.shrink();
                  //     }
                  //   },
                  // ),
                ],
              ),
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
          child: Column(
            children: [
              //SizedBox(height: 20.0),
              // Text("Username: ${userDoc?.get('username') ?? 'N/A'}"),
              // Text("Email: ${userDoc?.get('email') ?? 'N/A'}"),
              // FirestorePostDisplay(),

              // MyPost(),
              // SizedBox(height: 1.0),
              // MyPost(),
              Expanded(
                child: FirestorePostDisplay(),
              ),
            ],
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
                  onPressed: () {},
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

class NotificationProvider extends ChangeNotifier {
  int _notificationCount = 0;

  int get notificationCount => _notificationCount;

  void addNotification() {
    _notificationCount++;
    notifyListeners();
  }
}
