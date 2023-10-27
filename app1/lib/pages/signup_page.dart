import 'package:flutter/material.dart';
import 'package:Eventlyst/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // to store data in firestore
import 'package:Eventlyst/pages/auth_service/auth_service.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _username = TextEditingController();
  bool passToggle = true;

  createUserWithEmailAndPassword() async {
    try {
      setState(() {
        isLoading = true;
      });

      final String email = _email.text.trim();
      final String password = _password.text.trim();

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // User registered successfully with Firebase Authentication.
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .get();

        // Store user data in Firestore.
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user!.uid)
            .set({
          'name': _name.text,
          'username': _username.text,
          'email': email,

          // Add other user data fields as needed.
        });

        setState(() {
          isLoading = false;
        });

        // After successful registration, navigate to the home page.
        Navigator.pushReplacementNamed(
          context,
          MyRoutes.homeRoute,
          arguments: {
            'userDoc': userDoc,
            //  userDoc.data() // Pass the user data as a map
          },
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });

      // Handle registration errors
      print('Error during registration: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          // children: [
          // child: Padding(
          //   padding: const EdgeInsets.all(20.0),
          //   child: Form(
          //     key: _formKey,
          //     child: OverflowBar(
          //       overflowAlignment: OverflowBarAlignment.center,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.12),
            Text(
              "SIGNUP",
              style: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.08,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Text(
              "Lets Get Started !",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: MediaQuery.of(context).size.width * 0.05,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _name,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Full name is empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Name",
                        labelText: "Full Name",
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    TextFormField(
                      controller: _username,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Username is empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Username",
                        labelText: "Username",
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    TextFormField(
                      controller: _email,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Email is empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Email",
                        labelText: "Email",
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _password,
                      obscureText: passToggle,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return "Password is empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Enter Password",
                        labelText: "Password",
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
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.00,
                    // ),
                    TextButton(
                        onPressed: () {}, child: Text("forget password ?")),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  await createUserWithEmailAndPassword();

                  // After successful registration, navigate to the home page
                  Navigator.pushNamed(context, MyRoutes.homeRoute);
                }
              },
              child: isLoading
                  ? CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text("Register"),
              style: TextButton.styleFrom(
                minimumSize: Size(140, 50),
                backgroundColor: Colors.black,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Text(
              "or Sign up using",
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
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
                    onPressed: authService.signInWithGoogle,
                  )
                ],
              ),
            ),
            // SizedBox(
            //   height: 15,
            // ),
            Container(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account ?"),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, MyRoutes.loginRoute);
                    },
                    child: Text("Log In")),
              ],
            ))
          ],
          // ),
        ),
      ),
    );
  }
}
