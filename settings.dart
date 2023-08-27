import 'package:flutter/material.dart';

class Mysettings extends StatefulWidget {
  const Mysettings({super.key});

  @override
  State<Mysettings> createState() => _MysettingsState();
}

class _MysettingsState extends State<Mysettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.black,
      ),
    );
  }
}
