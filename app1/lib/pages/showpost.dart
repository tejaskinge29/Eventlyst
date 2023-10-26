import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:Eventlyst/utils/routes.dart';

class showpost extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Change to your desired background color
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Eventlyst"),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, MyRoutes.remRoute);
            },
            icon: const Icon(Icons.notifications_none_sharp),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 5),
        // Wrap the contents with a SingleChildScrollView
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  'Music Concert',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                'Greetings from Department of Electronics & Telecommunication Engineering, Yeshwantrao Chavan College of Engineering (YCCE), Nagpur.\n3 Day’s Student Training Program (STP) on "Unity Scripting: Bringing Your Ideas to Life" under the Aegis of IQAC & IETE Student Chapter YCCE is scheduled in the department during 05-07 August 2023.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "assets/images/design.jpg",
                  width: 300,
                  height: 300,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30),
                    child: Text(
                      'Free : Free',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 100),
                    child: Text(
                      'Time : 12:30 pm',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Text(
                          'Venue : YCCE',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 80),
                    child: Text(
                      'Date : 05-12-24',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                onPressed: () {
                  _showRegisterDialog(context);
                },
                child: Text('Register now'),
              ),
            ),
          ],
        ),
      ),
      // Navigation bar
      bottomNavigationBar: Container(
        height: (MediaQuery.of(context).size.height * 0.1),
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GNav(
            gap: 12,
            // backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.black,
            tabs: [
              GButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    MyRoutes.homeRoute,
                  );
                },
                icon: Icons.home,
              ),
              GButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.searchRoute);
                },
                icon: Icons.search,
              ),
              GButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.postRoute);
                },
                icon: Icons.post_add,
              ),
              GButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    MyRoutes.orgRoute,
                  );
                },
                icon: Icons.school,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to show the dialog
  void _showRegisterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Registration Successful'),
          content: Text('You have successfully registered for the event.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
