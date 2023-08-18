import 'package:app1/utils/routes.dart';
import 'package:flutter/material.dart';
class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text("SIGN UP",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w300,
              height: 6,
            ),
            ),

            Text("Lets Get Started !",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 25,
            ),
            ),
            SizedBox(height: 10),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0 , horizontal: 30.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText:"Enter Your Full Name",
                        labelText:"Name",
                      ),
                    ),
                  ],
                )
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0 , horizontal: 30.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText:"Enter Your Username",
                        labelText:"Username",
                      ),
                    ),
                  ],
                )
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0 , horizontal: 30.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText:"Enter Your Email ID",
                        labelText:"Email",
                      ),
                    ),
                  ],
                )
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0 , horizontal: 30.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText:"Create Password",
                        labelText:"Password",
                      ),
                    ),
                  ],
                )
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0 , horizontal: 30.0),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText:"Your Password",
                        labelText:"Confirm Password",
                      ),
                    ),
                  ],
                )
            ),
            SizedBox(height: 4,),
            ElevatedButton(onPressed:(){
              Navigator.pushNamed(context, MyRoutes.homeRoute);
            } , child: Text("Register"),
              style: TextButton.styleFrom(
                minimumSize:Size(140,50),
                backgroundColor: Colors.black,
              ),

            ),
            SizedBox(height: 10,),
            Text("or sign up using",),
            SizedBox(height: 20,),
            Container(
              child: Column(
                children: [
                  Image.asset("assets/images/google.png",
                    height: 45,
                    width: 45,),
                ],
              ),
            ),
            Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text("Already have an account ?"),
                    TextButton(onPressed: (){
                      Navigator.pushNamed(context, MyRoutes.loginRoute);
                    } ,child:Text("Login.")),
                  ] ,
                )

            )

          ],
        ),
      ),
    );
  }
}
