import 'package:app1/utils/routes.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            Text(
              "LOGIN",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.08,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Text(
              "Welcome !",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.06,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              "Please sign in to continue.",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.04,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Enter Username",
                        labelText: "Username",
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your ID';
                        }
                        // Regular expression to validate Gmail format
                        RegExp gmailPattern = RegExp(
                          r"^[a-zA-Z0-9._%+-]+@(gmail\.com|ycce\.in|ycce\.org)$",
                          caseSensitive: false,
                        );
                        if (!gmailPattern.hasMatch(value)) {
                          return 'Please enter a valid Gmail ID';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        labelText: "Password",
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    TextButton(
                        onPressed: () {}, child: Text("Forget password ?")),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Navigator.pushNamed(context, '/homeRoute');
                  Navigator.pushNamed(context, MyRoutes.homeRoute);
                }
              },
              child: Text("LogIn"),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(140, 50),
                primary: Colors.black,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Text("or login using"),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Container(
              child: Column(
                children: [
                  Image.asset(
                    "assets/images/google.png",
                    height: MediaQuery.of(context).size.height * 0.045,
                    width: MediaQuery.of(context).size.width * 0.12,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.06,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account ?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.signupRoute);
                    },
                    child: Text("Sign Up"),
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
