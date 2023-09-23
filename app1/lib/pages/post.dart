import 'package:flutter/material.dart';
import 'package:app1/utils/routes.dart';

class MyPost extends StatefulWidget {
  const MyPost({super.key});

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width * 0.9),
      height: (MediaQuery.of(context).size.height * 0.5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 5.0,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image.asset(
            "assets/images/profile.png",
            width: 50,
            height: 50,
          ),
          Text("UserName"),
        ],
      ),
    );
  }
}
