import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:app1/utils/routes.dart';

class Search_Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Search"),
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
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
          child: GNav(
            gap: 12,
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.black,
            tabs: [
              GButton(onPressed: () {
                Navigator.pushNamed(context, MyRoutes.homeRoute,);
              }, icon: Icons.home,),
              GButton(onPressed: () {Navigator.pushNamed(context, MyRoutes.searchRoute);}, icon: Icons.search,),
              GButton(onPressed: () {Navigator.pushNamed(context, MyRoutes.postRoute);}, icon: Icons.post_add,),
              GButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.orgRoute,);
                }, icon: Icons.school,),
            ],
          ),
        ),
      ),
    );
  }
}
