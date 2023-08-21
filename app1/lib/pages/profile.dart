import 'package:flutter/material.dart';
import 'package:app1/utils/routes.dart';

// void main() {
//   runApp(Profileedit());
// }

// class Profileedit extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Profile Example',
//       home: ProfilePage(),
//     );
//   }
// }

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton(
          onPressed: () {
            // Add your navigation logic here
            Navigator.pop(
                context,
                MyRoutes
                    .homeRoute); // This will navigate back to the previous screen
          },
        ),
        title: const Text("Profile"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
                if (isEditing) {
                  nameController.text = "Personal Name"; // Initialize the text
                }
              });
            },
            icon: Icon(isEditing ? Icons.done : Icons.edit_outlined),
          ),
        ],
      ),
      body: ProfileBody(isEditing: isEditing, nameController: nameController),
    );
  }
}

class ProfileBody extends StatelessWidget {
  final bool isEditing;
  final TextEditingController nameController;

  ProfileBody({required this.isEditing, required this.nameController});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Column(
        children: [
          ClipOval(
            child: Image.asset(
              "assets/images/profile.png",
              width: 100,
              height: 100,
            ),
          ),
          SizedBox(height: 10),
          isEditing
              ? TextField(
                  controller: nameController,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                    focusedBorder: InputBorder.none,
                    hintText: "Enter Name",
                  ),
                )
              : Text(
                  nameController.text,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
          SizedBox(height: 5),
          Text(
            "@username",
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),
          SizedBox(height: 10),
          ToggleButtonsExample(),
        ],
      ),
    );
  }
}

class ToggleButtonsExample extends StatefulWidget {
  @override
  _ToggleButtonsExampleState createState() => _ToggleButtonsExampleState();
}

class _ToggleButtonsExampleState extends State<ToggleButtonsExample> {
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
      child: ToggleButtons(
        isSelected: isSelected,
        onPressed: _onButtonPressed,
        children: [
          Container(
            width: 150, // Adjust the width as needed
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
            width: 150, // Adjust the width as needed
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
    );
  }
}
