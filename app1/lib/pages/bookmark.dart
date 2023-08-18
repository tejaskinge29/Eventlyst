import 'package:flutter/material.dart';
class MyBookmark extends StatefulWidget {
  const MyBookmark({super.key});

  @override
  State<MyBookmark> createState() => _MyBookmarkState();
}

class _MyBookmarkState extends State<MyBookmark> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmark"),
        backgroundColor: Colors.black,
      ),
    );
  }
}
