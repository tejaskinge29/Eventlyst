import 'package:Eventlyst/pages/orgPage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Eventlyst/utils/routes.dart';
import 'package:Eventlyst/user_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:Eventlyst/user_data_provider.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:Eventlyst/pages/acpost.dart';
import 'package:Eventlyst/pages/acattend.dart';
import 'package:Eventlyst/pages/auth_service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class UserDataManager {
  AuthService authService = AuthService();
  late SharedPreferences _prefs;
  late Map<String, String?> userData;

  Future<void> initialize() async {
    _prefs = await SharedPreferences.getInstance();
    userData = await authService.getUserDataFromSharedPreferences();
  }

  String? getUserId() {
    return _prefs.getString('userId');
  }

  String? getUsername() {
    return userData['username'];
  }

  String? getEmail() {
    return userData['email'];
  }
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();
  bool isEditing = false;
  TextEditingController nameController =
      TextEditingController(text: "Personal Name");
  late UserDataManager userDataManager;

  @override
  void initState() {
    super.initState();
    userDataManager = UserDataManager();
    _initUserData();
  }

  Future<void> _initUserData() async {
    try {
      await userDataManager.initialize();
      print('Username: ${userDataManager.getUsername()}');
      setState(() {}); // Trigger a rebuild after initializing data
    } catch (error) {
      print('Error initializing user data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    String? userId = userDataManager.getUserId();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, MyRoutes.homeRoute);
          },
        ),
        title: const Text("Profile"),
        // actions: <Widget>[
        //   IconButton(
        //     onPressed: () {
        //       setState(() {
        //         isEditing = !isEditing;
        //         if (isEditing) {
        //           nameController.text = "Personal Name";
        //         }
        //       });
        //     },
        //     icon: Icon(isEditing ? Icons.done : Icons.edit_outlined),
        //   ),
        // ],
      ),
      body: ProfileBody(
        isEditing: isEditing,
        nameController: nameController,
        userId: userId ?? '',
        username: userDataManager
            .getUsername(), // Pass the username to the ProfileBody
        userDataManager: userDataManager,
      ),
    );
  }
}

class ProfileBody extends StatelessWidget {
  final bool isEditing;
  final TextEditingController nameController;
  final String userId;
  final String? username;
  // final String profilePhotoUrl;

  final UserDataManager userDataManager;

  ProfileBody({
    required this.isEditing,
    required this.nameController,
    required this.userId,
    required this.username,
    required this.userDataManager,
  });

  // final bool isEditing;
  // final TextEditingController nameController;
  // final String userId;

  // ProfileBody({
  //   required this.isEditing,
  //   required this.nameController,
  //   required this.userId,
  // }) {
  //   _initPrefs();
  // }

  //  hosted post  data
  // Future<List<Map<String, dynamic>>> getHostedPosts(String userId) async {
  //   try {
  //     CollectionReference posts =
  //         FirebaseFirestore.instance.collection('posts');

  //     QuerySnapshot postsQuery =
  //         await posts.where('userId', isEqualTo: userId).get();

  //     if (postsQuery.docs.isNotEmpty) {
  //       // Explicitly cast the data to the correct type
  //       List<Map<String, dynamic>> hostedPosts = postsQuery.docs
  //           .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
  //           .toList();

  //       return hostedPosts;
  //     } else {
  //       return [];
  //     }
  //   } catch (e) {
  //     print('Error fetching hosted posts: $e');
  //     return [];
  //   }
  // }

  File? _image;

  Future<void> updateUserData() async {
    String newName = nameController.text;
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'name': newName,
    });
  }

  // Future<Map<String, dynamic>> getUserData(String userId) async {
  //   try {
  //     CollectionReference users =
  //         FirebaseFirestore.instance.collection('users');

  //     QuerySnapshot userQuery =
  //         await users.where('userId', isEqualTo: userId).limit(1).get();

  //     if (userQuery.docs.isNotEmpty) {
  //       var userData = userQuery.docs.first.data();
  //       if (userData != null && userData is Map<String, dynamic>) {
  //         return userData;
  //       }
  //     }
  //     return {};
  //   } catch (e) {
  //     print('Error fetching user data: $e');
  //     return {};
  //   }
  // }
  // Future<Map<String, dynamic>> getUserData(String userId) async {
  //   try {
  //     // Assuming you have a 'users' collection in Firestore
  //     DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
  //         .instance
  //         .collection('users')
  //         .doc(userId)
  //         .get();

  //     if (userDoc.exists) {
  //       // If the document exists, return the user data
  //       Map<String, dynamic> userData = userDoc.data() ?? {};
  //       return userData;
  //     } else {
  //       // If the document doesn't exist, handle it accordingly
  //       return {};
  //     }
  //   } catch (e) {
  //     print('Error fetching user data: $e');
  //     return {};
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // String profilePhotoUrl = userDataManager['profilePhotoUrl'] ?? '';
    // String? userId = getUserIdFromSharedPreferences();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
              child: Column(
                children: [
                  ClipOval(
                    // Implement this when we write the logic for storing profile pic and fetching it from users collection
                    // child: _image != null
                    //     ? Image.file(
                    //         _image!,
                    //         width: 100,
                    //         height: 100,
                    //       )
                    //     : profilePhotoUrl.isNotEmpty
                    //         ? Image.network(
                    //             profilePhotoUrl,
                    //             width: 100,
                    //             height: 100,
                    //           )
                    child: Image.asset(
                      "assets/images/profile.png",
                      width: 80,
                      height: 80,
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Column(
                      children: [
                        Text(
                          username ?? 'N/A',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(height: 3),
                        ToggleButtonsExample(
                          userId: 'userId',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
    }
  }
}

class ToggleButtonsExample extends StatefulWidget {
  final String userId; // Pass userId as a parameter to the widget

  ToggleButtonsExample({required this.userId});

  @override
  _ToggleButtonsExampleState createState() => _ToggleButtonsExampleState();
}

class _ToggleButtonsExampleState extends State<ToggleButtonsExample> {
  int selectedTabIndex = 0;
  List<bool> isSelected = [true, false];

  void _onButtonPressed(int index) {
    setState(() {
      for (int buttonIndex = 0;
          buttonIndex < isSelected.length;
          buttonIndex++) {
        isSelected[buttonIndex] = buttonIndex == index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ToggleButtons(
            isSelected: isSelected,
            onPressed: (index) {
              setState(() {
                for (int buttonIndex = 0;
                    buttonIndex < isSelected.length;
                    buttonIndex++) {
                  isSelected[buttonIndex] = buttonIndex == index;
                }
                selectedTabIndex = index;
              });
            },
            children: [
              Container(
                width: 150,
                child: Center(
                  child: Text(
                    'Event Hosted',
                    style: TextStyle(
                      fontSize: 15,
                      color: isSelected[0] ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              Container(
                width: 150,
                child: Center(
                  child: Text(
                    'Attended',
                    style: TextStyle(
                      fontSize: 15,
                      color: isSelected[1] ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
            selectedColor: Colors.black,
            color: Colors.white,
            fillColor: Colors.black,
            borderRadius: BorderRadius.circular(8.0),
          ),
          Visibility(
            visible: selectedTabIndex == 0,
            child: HostedPanel(),
            // child: acpost(),
          ),
          Visibility(
            visible: selectedTabIndex == 1,
            child: AttendedPanel(),
          ),
        ],
      ),
    );
  }
}

class HostedPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Add a container with size constraints
      width: 600, // Set width as needed
      height: 800, // Set height as needed
      child: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: acpost(),
          ),
        ],
      ),
    );
  }
}

class AttendedPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Add a container with size constraints
      width: 600, // Set width as needed
      height: 800, // Set height as needed
      child: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: acattend(),
          ),
        ],
      ),
    );
  }
}

// class FirestoreService {
//   static Future<List<Map<String, dynamic>>> getHostedPosts(
//       String userId) async {
//     try {
//       // Assuming you have a 'posts' collection in Firestore
//       CollectionReference posts =
//           FirebaseFirestore.instance.collection('posts');

//       // Query for posts where the 'userId' field matches the user's ID
//       QuerySnapshot postQuery =
//           await posts.where('userId', isEqualTo: userId).get();

//       // Check if any documents match the query
//       if (postQuery.docs.isNotEmpty) {
//         // Map the data from each document and return the list
//         return postQuery.docs
//             .map((doc) => doc.data() as Map<String, dynamic>)
//             .toList();
//       } else {
//         return [];
//       }
//     } catch (e) {
//       print('Error fetching hosted posts: $e');
//       return [];
//     }
//   }
// }
