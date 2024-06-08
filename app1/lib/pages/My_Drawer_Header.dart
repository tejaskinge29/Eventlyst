import 'package:Eventlyst/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Eventlyst/pages/auth_service/auth_service.dart';

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({Key? key}) : super(key: key);

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  AuthService authService = AuthService();
  late SharedPreferences _prefs;
  late Map<String, String?> userData = {};
  late String? username;
  late String? email;
  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    await _initUserData(); // Wait for _initUserData to complete
  }

  Future<void> _initUserData() async {
    try {
      // Fetch user data from SharedPreferences
      userData = await authService.getUserDataFromSharedPreferences();

      // Use the fetched user data as needed
      String? userId = userData['userId'];
      username = userData['username'];
      // String? username = userData['username'];
      String? name = userData['name'];
      email = userData['email'];

      // Perform any additional logic with the user data

      // Print the data
      print('Username: $username');
    } catch (error) {
      print('Error initializing user data: $error');
    }
    if (mounted) {
      setState(() {}); // Trigger a rebuild after initializing data
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get user data from SharedPreferences
    String? userId = getUserIdFromSharedPreferences();

    return Container(
      color: Colors.black,
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 0),
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                // Load the user's photoURL from SharedPreferences
                image: NetworkImage(
                  _prefs.getString('photoURL') ?? 'assets/images/profilew.png',
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.profileRoute, arguments: {
                'userId': userId,
              });
            },
            child: Text(
              // Load the user's displayName from SharedPreferences
              username ?? 'N/A',
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width * 0.04,
              ),
            ),
          ),
          Text(
            email ?? 'N/A',
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.03,
                color: Colors.white),
          ),
        ],
      ),
    );
  }

  String? getUserIdFromSharedPreferences() {
    return _prefs.getString('userId');
  }
}
