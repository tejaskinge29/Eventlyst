import 'package:Eventlyst/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({super.key});

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    final DocumentSnapshot? userDoc = args?['userDoc'];
    return Container(
      color: Colors.black,
      width: double.infinity,
      height: 200,
      padding: EdgeInsets.only(top: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 0),
            height: 70,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/profilew.png'),
              ),
              // image section ;
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.pushNamed(context, MyRoutes.profileRoute,
                    arguments: {'userDoc': userDoc});
              },
              child: Text(
                "${userDoc?.get('username') ?? 'N/A'}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              )),
          Text(
            "${userDoc?.get('email') ?? 'N/A'}",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.03,
                color: Colors.white),
          )
        ],
      ),
    );
  }
}
