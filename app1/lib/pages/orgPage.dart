import 'package:Eventlyst/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class orgLogin extends StatefulWidget {
  const orgLogin({super.key});

  @override
  State<orgLogin> createState() => _orgLoginState();
}

class _orgLoginState extends State<orgLogin> {
  final _formKey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("ORGANISATION"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Text(
                  "ORGANISATION",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.w300,
                    // height: 2,
                  ),
                ),
                Text(
                  "REGISTRATION",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.06,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailcontroller,
                  decoration: InputDecoration(
                    hintText: "Enter your Organisation E-ID",
                    labelText: "Email Id",
                    // border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your Gmail ID';
                    }
                    // Regular expression to validate Gmail format
                    RegExp gmailPattern = RegExp(
                      r"^[a-zA-Z0-9._%+-]+@(gmail\.com|ycce\.in|ycce\.org)$",
                      // General to access specific structure email
                      //   r"^[a-zA-Z0-9.a-zA-Z0-9.!#!$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                      // r"^[a-zA-Z0-9._%+-]+@(gmail\.com|example\.in|example\.org)$",
                      caseSensitive: false,
                    );
                    if (!gmailPattern.hasMatch(value)) {
                      return 'Please enter a valid Gmail ID';
                    }
                    return null;
                  },
                  // validator: (value) {
                  //   if (value!.isEmpty) {
                  //     return "Enter Email";
                  //   }
                  //   bool emailValid = RegExp(
                  //           r"^[a-zA-Z0-9.a-zA-Z0-9.!#!$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                  //       .hasMatch(value);
                  //   if (!emailValid) {
                  //     return "Enter Valid Email";
                  //   }
                  // },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                TextFormField(
                  keyboardType: TextInputType.visiblePassword,
                  controller: passcontroller,
                  obscureText: passToggle,
                  decoration: InputDecoration(
                    hintText: "Enter your password",
                    labelText: "Password",
                    // border: OutlineInputBorder(),
                    suffix: InkWell(
                      onTap: () {
                        setState(() {
                          passToggle = !passToggle;
                        });
                      },
                      child: Icon(
                          passToggle ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter Password";
                    } else if (passcontroller.text.length < 6) {
                      return "Password length should be more than 6 charachter";
                    }
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Navigator.pushNamed(context, '/homeRoute');
                      Navigator.pushNamed(context, MyRoutes.orghomeRoute);
                    }
                  },
                  child: Text("LogIn"),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(140, 50),
                    primary: Colors.black,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("login as a Admin :"),
                    TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, MyRoutes.adminRoute);
                        },
                        child: Text(
                          "Admin Login",
                          style: TextStyle(fontSize: 15),
                        )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Note",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "You can follow the events related to your organisation so that you can stay up to date with your organisation  events. ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w300,
                          fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
