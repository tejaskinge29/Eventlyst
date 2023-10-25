import 'package:flutter/material.dart';
import 'package:Eventlyst/pages/auth_service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Eventlyst/utils/routes.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  AuthService authService = AuthService();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  bool passToggle = true;

// Function to sign in with Google
  signInWithGoogle() async {
    try {
      await authService.signInWithGoogle();
      Navigator.pushNamed(
        context,
        MyRoutes.homeRoute,
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Google Sign-In Error: $e"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Handle back button press as needed
        // Return 'true' to allow the back navigation, or 'false' to block it
        return false;
      },
      child: Scaffold(
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
                "Please sign in to continue !",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.04,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 30.0),
                child: Form(
                  // key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _emailController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "email is empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: "Enter e-mail id",
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        // controller: passcontroller,
                        obscureText: passToggle,
                        controller: _passwordController,
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return "Password is empty";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: "Enter Password",
                          labelText: 'Password',
                          suffix: InkWell(
                            onTap: () {
                              setState(() {
                                passToggle = !passToggle;
                              });
                            },
                            child: Icon(passToggle
                                ? Icons.visibility
                                : Icons.visibility_off),
                          ),
                        ),
                        // obscureText: true,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      // SizedBox(height: 16),
                      TextButton(
                          onPressed: () {}, child: Text("forget password ?")),
                      // SizedBox(
                      //   height: 20,
                      // ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    String email = _emailController.text.trim();
                    String password = _passwordController.text.trim();

                    // Sign in with Firebase Authentication
                    UserCredential userCredential =
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email,
                      password: password,
                    );

                    if (userCredential.user != null) {
                      // User is authenticated, get user data from Firestore
                      DocumentSnapshot userDoc = await FirebaseFirestore
                          .instance
                          .collection('users')
                          .doc(userCredential.user!.uid)
                          .get();

                      if (userDoc.exists) {
                        // User data found in Firestore, you can access it like userDoc['fieldName']
                        // Example:
                        // String username = userDoc['username'];
                        print('Username: ${userDoc['username']}');
                        print('Email: ${userDoc['email']}');
                        // Pass user data to the home page
                        Navigator.pushReplacementNamed(
                          context,
                          MyRoutes.homeRoute,
                          arguments: {
                            'userDoc': userDoc,
                            //  userDoc.data() // Pass the user data as a map
                          },
                        );
                      } else {
                        // User data not found in Firestore
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('User data not found.'),
                          ),
                        );
                      }
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Login failed: $e'),
                      ),
                    );
                  }
                },
                child: isLoading
                    ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text("Log In"),
                style: TextButton.styleFrom(
                  minimumSize: Size(140, 50),
                  backgroundColor: Colors.black,
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Text(
                "or login using",
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              // Google login authentication
              Container(
                child: Column(
                  children: [
                    IconButton(
                      icon: Image.asset(
                        'assets/images/google.png',
                        height: MediaQuery.of(context).size.height * 0.045,
                        width: MediaQuery.of(context).size.width * 0.12,
                      ),
                      // iconSize: 50,
                      // onPressed: authService.handleSignIn,
                      onPressed: signInWithGoogle,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dont't have an account ?"),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, MyRoutes.signupRoute);
                      },
                      child: Text("Sign Up")),
                ],
              ))
              //         ],
              //       )),
              //     ),
              //   ),

              //   //   ),
              //   // ),
            ],
          ),
        ),
      ),
    );
  }
}
