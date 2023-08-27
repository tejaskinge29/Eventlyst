import 'package:app1/pages/routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: BackButton() ,
        title: const Text("Profile"),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit_outlined),
          ),
        ],
      ),
      body: ProfileBody(),
    );
  }
}

class ProfileBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
      child: Column(
        children: [
          Image.asset("assets/images/profile.png",height: 100,),
          SizedBox(height: 10),
          Text(
            "Personal Name",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(height: 5),
          Text(
            "@username",
            style: TextStyle(fontSize: 15, color: Colors.black),
          ),

          SizedBox(height: 15),
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
    );
  }
}
