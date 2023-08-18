import 'package:app1/utils/routes.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/intro.png",
              height: 750,
            ),
        Text("Welcome To",
            style:TextStyle(
              height: -19,
              fontWeight: FontWeight.w400,
              fontSize: 35,
            )),
            SizedBox(height: 20,),
            Text("Eventlyst",
            style: TextStyle(
              height: -9,
              fontSize: 28,
              fontWeight: FontWeight.w800,
            ),
            ),
            SizedBox(height: 70,),
            Container(
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(onPressed:(){
                    // login path
                    Navigator.pushNamed(context, MyRoutes.loginRoute);
                  },
                    child:
                    Text("Login",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                      fontWeight: FontWeight.w400),
                    ),
                  ),
                  VerticalDivider(
                    color: Colors.black,
                    width: 70,
                    thickness: 4,
                  ),
                  TextButton(onPressed:(){
                    // Sign up path
                    Navigator.pushNamed(context, MyRoutes.signupRoute);
                  },
                    child:
                    Text("Sign Up",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              )

              ),


    ],
        ),
      ),
    );
}
}
