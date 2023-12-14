import 'package:flutter/material.dart';
import 'package:Eventlyst/utils/routes.dart';

class MyPost extends StatefulWidget {
  const MyPost({super.key});

  @override
  State<MyPost> createState() => _MyPostState();
}

class _MyPostState extends State<MyPost> {
  bool isStarFilled = false;
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        color: Colors.white,
        width:
            screenWidth > 600 ? 600 : double.infinity, // Max width for tablets
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        child: Image.asset(
                          "assets/images/profile.png",
                          width: screenWidth > 600
                              ? 70
                              : 35, // Increase size for tablets
                          height: screenWidth > 600 ? 70 : 35,
                        ),
                        radius: 20,
                      ),
                      SizedBox(width: screenWidth > 600 ? 16 : 8),
                      Expanded(
                        child: Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'UserName',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth > 600 ? 24 : 16),
                              ),
                              Text(
                                '04 April',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: screenWidth > 600 ? 14 : 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: screenWidth > 600 ? 16 : 10),
                      IconButton(
                        iconSize: screenWidth > 600 ? 40 : 30,
                        color: Colors.yellow,
                        icon: isStarFilled
                            ? Icon(Icons.star, color: Colors.yellow)
                            : Icon(Icons.star_border_outlined),
                        onPressed: () {
                          setState(() {
                            isStarFilled = !isStarFilled;
                          });
                        },
                      ),
                    ],
                  ),
                  // Add another Row here
                  Row(
                    children: [
                      Icon(
                        Icons.fiber_manual_record,
                        color: Colors.yellow,
                        size: screenWidth > 600
                            ? 24
                            : 20, // Increase size for tablets
                      ),
                      SizedBox(width: screenWidth > 600 ? 16 : 8),
                      Text(
                        'Music Concert',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth > 600 ? 28 : 20),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              width: double.infinity,
              child: Image.asset(
                "assets/images/design.jpg",
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
              child: Text(
                'Greetings from Department of Electronics & Telecommunication Engineering,......',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Container(
              width: double.infinity,
              // Set the desired height
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Row(
                      children: [
                        // Text(
                        //   'Greetings from Department of Electronics ...',
                        //   style: TextStyle(
                        //       fontWeight: FontWeight.normal,
                        //       fontSize: screenWidth > 600 ? 18 : 15),
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Text(
                          'Free : Free',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: screenWidth > 600 ? 18 : 15),
                        ),
                        SizedBox(
                            width: screenWidth > 600
                                ? 150.0
                                : 100.0), // Adjust the spacing
                        ElevatedButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, MyRoutes.showpostRoute);
                          },
                          icon: Icon(
                            Icons.bookmark_add_outlined,
                            size: screenWidth > 600
                                ? 24
                                : 15, // Increase icon size for tablets
                          ),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(screenWidth > 600 ? 180 : 135,
                                30), // Adjust the button size
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          label: Text('Register now'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
