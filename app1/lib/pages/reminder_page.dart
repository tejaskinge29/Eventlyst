import 'package:flutter/material.dart';

class Myreminder extends StatefulWidget {
  const Myreminder({super.key});

  @override
  State<Myreminder> createState() => _MyreminderState();
}

class _MyreminderState extends State<Myreminder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registered Events"),
        backgroundColor: Colors.black,
      ),
    );
  }
}
