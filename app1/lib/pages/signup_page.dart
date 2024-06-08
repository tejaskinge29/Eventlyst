import 'package:flutter/material.dart';
import 'package:Eventlyst/utils/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // to store data in firestore
import 'package:Eventlyst/pages/auth_service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

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
        DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
            .instance
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
          'userId': userCredential.user!.uid,
          // Add other user data fields as needed.
        });

        // After successful signup, set isLoggedIn to true in shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('isLoggedIn', true);
        await prefs.setString('userId', userCredential.user!.uid);
        await prefs.setString('username', _username.text);
        await prefs.setString('name', _name.text);
        await prefs.setString('email', email);

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
                      onPressed: () => authService.signInWithGoogle(context))
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
