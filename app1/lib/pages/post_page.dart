import 'package:flutter/material.dart';

class Mypost extends StatefulWidget {
  const Mypost({super.key});

  @override
  State<Mypost> createState() => _MypostState();
}

class _MypostState extends State<Mypost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
        backgroundColor:Colors.black,
      ),

      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0 , horizontal: 30.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 40,),
              TextField(
                decoration: InputDecoration(labelText: 'Event Title',border: OutlineInputBorder()),
                keyboardType: TextInputType.multiline,
                maxLines: null, // <-- SEE HERE
              ),
              SizedBox(height: 20,),
              TextField(
                decoration: InputDecoration(labelText: 'Event Discriptiion',border: OutlineInputBorder()),
                keyboardType: TextInputType.multiline,
                maxLines: null, // <-- SEE HERE
              ), SizedBox(height: 20,),
              TextField(
                decoration: InputDecoration(labelText: 'Venue',border: OutlineInputBorder()),
                keyboardType: TextInputType.multiline,
                maxLines: null, // <-- SEE HERE
              ),
            ],
          ),
        ),
      ),
    );
  }
}
