import 'package:Eventlyst/utils/routes.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          Text(
            "Welcome To",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.08,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.15),
          Image.asset(
            "assets/images/intro.png",
            width: MediaQuery.of(context).size.width * 0.6,
          ),
          Text(
            "Eventlyst",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.07,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.15,
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, MyRoutes.loginRoute);
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                VerticalDivider(
                  color: Colors.black,
                  width: MediaQuery.of(context).size.width * 0.2,
                  thickness: 4,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, MyRoutes.signupRoute);
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
