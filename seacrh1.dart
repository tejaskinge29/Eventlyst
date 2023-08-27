import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:app1/pages/routes.dart';

class Search_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Search"),
        leading: BackButton(onPressed:(){Navigator.pushNamed(context, MyRoutes.homeRoute);} ,),
        actions: <Widget>[

        ],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        width: 450,
        padding: EdgeInsets.all(10.0),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13.0),
            ),
            filled: true,
            hintText: 'Search',
            fillColor: Color.fromARGB(217, 255, 255, 255),
            suffixIcon: Icon(Icons.search),
          ),
        ),
      ),

    );
  }
}
