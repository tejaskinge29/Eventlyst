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

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isEditing = false;
  TextEditingController nameController =
      TextEditingController(text: "Personal Name");

  @override
  Widget build(BuildContext context) {
    String userId = Provider.of<UserIdProvider>(context).userId;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, MyRoutes.homeRoute);
          },
        ),
        title: const Text("Profile"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
                if (isEditing) {
                  nameController.text = "Personal Name";
                }
              });
            },
            icon: Icon(isEditing ? Icons.done : Icons.edit_outlined),
          ),
        ],
      ),
      body: ProfileBody(
        isEditing: isEditing,
        nameController: nameController,
        userId: userId,
      ),
    );
  }
}

class ProfileBody extends StatelessWidget {
  final bool isEditing;
  final TextEditingController nameController;
  final String userId;
  ProfileBody(
      {required this.isEditing,
      required this.nameController,
      required this.userId});

//  hosted post  data
  Future<List<Map<String, dynamic>>> getHostedPosts(String userId) async {
    try {
      CollectionReference posts =
          FirebaseFirestore.instance.collection('posts');

      QuerySnapshot postsQuery =
          await posts.where('userId', isEqualTo: userId).get();

      if (postsQuery.docs.isNotEmpty) {
        // Explicitly cast the data to the correct type
        List<Map<String, dynamic>> hostedPosts = postsQuery.docs
            .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
            .toList();

        return hostedPosts;
      } else {
        return [];
      }
    } catch (e) {
      print('Error fetching hosted posts: $e');
      return [];
    }
  }

  File? _image;

  Future<void> updateUserData() async {
    String newName = nameController.text;
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'name': newName,
    });
  }

  Future<Map<String, dynamic>> getUserData(String userId) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      QuerySnapshot userQuery =
          await users.where('userId', isEqualTo: userId).get();

      if (userQuery.docs.isNotEmpty) {
        var userData = userQuery.docs.first.data();
        if (userData != null && userData is Map<String, dynamic>) {
          return userData;
        }
      }
      return {};
    } catch (e) {
      print('Error fetching user data: $e');
      return {};
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getUserData(userId),
      builder: (context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error loading user data');
        } else {
          Map<String, dynamic> userData = snapshot.data ?? {};
          String username = userData['username'] ?? '@username';
          String personalName = userData['personalName'] ?? 'Personal Name';
          String profilePhotoUrl = userData['profilePhotoUrl'] ?? '';

          return Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Column(
              children: [
                ClipOval(
                  child: _image != null
                      ? Image.file(
                          _image!,
                          width: 100,
                          height: 100,
                        )
                      : profilePhotoUrl.isNotEmpty
                          ? Image.network(
                              profilePhotoUrl,
                              width: 100,
                              height: 100,
                            )
                          : Image.asset(
                              "assets/images/profile.png",
                              width: 100,
                              height: 100,
                            ),
                ),
                SizedBox(height: 10),
                // ElevatedButton(
                //   onPressed: _pickImage,
                //   child: Text("Pick Image"),
                // ),
                isEditing
                    ? TextField(
                        controller: nameController,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 10),
                          focusedBorder: InputBorder.none,
                          hintText: "Enter Name",
                        ),
                      )
                    : Text(
                        personalName,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                SizedBox(height: 5),
                Text(
                  "@$username",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Text(
                  "$userId",
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                ToggleButtonsExample(
                  userId: 'userId',
                ),
              ],
            ),
          );
        }
      },
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
    return Column(
      children: [
        Text(
          "Event Hosted Panel",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class AttendedPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Attended Panel",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ],
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
