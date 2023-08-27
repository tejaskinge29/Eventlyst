import 'package:app1/utils/routes.dart';
import 'package:flutter/material.dart';

class MyHeaderDrawer extends StatefulWidget {
  const MyHeaderDrawer({super.key});

  @override
  State<MyHeaderDrawer> createState() => _MyHeaderDrawerState();
}

class _MyHeaderDrawerState extends State<MyHeaderDrawer> {
  @override
  Widget build(BuildContext context) {
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
                Navigator.pushNamed(context, MyRoutes.profileRoute);
              },
              child: Text(
                "Pawan Balpande",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.04),
              )),
          Text(
            "pawanbalpande00@gmail.com",
            style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.03,
                color: Colors.white),
          )
        ],
      ),
    );
  }
}
