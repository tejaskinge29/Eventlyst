import 'package:flutter/material.dart';

class Myfeedback extends StatefulWidget {
  const Myfeedback({super.key});

  @override
  State<Myfeedback> createState() => _MyfeedbackState();
}

class _MyfeedbackState extends State<Myfeedback> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedback"),
        backgroundColor: Colors.black,
      ),
    );
  }
}
