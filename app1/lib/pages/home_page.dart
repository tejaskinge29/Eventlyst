
import 'package:app1/My_Drawer_List.dart';
import 'package:app1/pages/My_Drawer_Header.dart';
import 'package:app1/pages/post_page.dart';
import 'package:app1/utils/routes.dart';
import 'package:app1/widdget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'bnav.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Eventlyst"),
        actions: <Widget>[
          IconButton(onPressed: () {
            Navigator.pushNamed(context, MyRoutes.remRoute);
          }, icon: const Icon(Icons.notifications_none_sharp),
          ),
        ],
      ),
      drawer: Drawer(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                MyHeaderDrawer(),
                MyDrawerList(),
              ],
            ),
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