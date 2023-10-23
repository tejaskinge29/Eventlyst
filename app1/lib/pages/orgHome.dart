import 'package:Eventlyst/utils/routes.dart';
import 'package:flutter/material.dart';

class MyOrgHome extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<MyOrgHome> {
  bool isEditing = false;
  TextEditingController nameController =
      TextEditingController(text: "Organization Name");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton(),
        title: const Text("Organization"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
                if (isEditing) {
                  nameController.text =
                      "Organization Name"; // Initialize the text
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
              "assets/images/org.png",
              width: 100,
              height: 100,
            ),
          ),
          SizedBox(height: 20),
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
          SizedBox(height: 30),
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
  List<bool> isSelected = [true, false, false]; // Adjusted for three buttons

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
            width: 100, // Adjust the width as needed
            child: Column(
              children: [
                // Image.asset(
                //   'assets/feedw.png',
                //   width: 60,
                //   height: 60,
                // ),
                Center(
                  child: Container(
                    alignment: Alignment.center,
                    width: 50, // Adjust the width as needed
                    height: 50, // Adjust the height as needed
                    child: isSelected[0]
                        ? ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              isSelected[0] ? Colors.white : Colors.black,
                              BlendMode.srcIn,
                            ),
                            child: Image.asset(
                              'assets/images/feedw.png',
                              width: 25,
                              height: 25,
                            ),
                          )
                        : Image.asset(
                            'assets/images/feedb.png',
                            width: 25,
                            height: 25,
                          ),
                  ),
                ),
                // Text(
                //   'Event ',
                //   style: TextStyle(
                //     fontSize: 15,
                //     color: isSelected[0] ? Colors.white : Colors.black,
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            width: 100, // Adjust the width as needed
            child: Center(
              child: Text(
                'DEPT',
                style: TextStyle(
                  fontSize: 15,
                  color: isSelected[1] ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
          Container(
            width: 100, // Adjust the width as needed
            child: Center(
              child: Text(
                'CLUBS',
                style: TextStyle(
                  fontSize: 15,
                  color: isSelected[2] ? Colors.white : Colors.black,
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
