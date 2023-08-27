import 'package:app1/pages/auth_service/auth_service.dart';
import 'package:app1/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:app1/pages/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app1/pages/authPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  signInWithEmailAndPassword()async{
    try {
      setState(() {
         isLoading = true;

      });

      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email.text,
          password: _password.text,
      );
      setState(() {
         isLoading = false;
      });
    } on FirebaseAuthException catch (e) {
      setState(() {
         isLoading = false;
      });
      if (e.code == 'user-not-found') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("No user found for that email."),
          ),
        );

      } else if (e.code == 'wrong-password') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Wrong password provided for that user."),
          ),
        );

      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthService authService = AuthService();
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(

            padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: OverflowBar(
                  overflowAlignment: OverflowBarAlignment.center,
                  children: [
                  Text("LOGIN",style: TextStyle(fontSize: 30,fontWeight:FontWeight.w200),),
                    SizedBox(height: 40,),
                    Text("Welcome !",style: TextStyle(fontSize: 25,fontWeight:FontWeight.w600),),
                    SizedBox(height: 10,),
                    Text("Please sign in to continue !",style: TextStyle(fontSize: 15,fontWeight:FontWeight.w300),),
                    SizedBox(height: 60,),
                    TextFormField(
                      controller: _email,
                      validator: (text){
                        if (text == null || text.isEmpty){
                          return "email is empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText:"Enter Username",
                        labelText:"Username",
                      ),
                    ),
                    SizedBox(height: 30,),
                TextFormField(
                controller: _password,
                validator: (text){
                  if (text == null || text.isEmpty){
                    return "Password is empty";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText:"Enter Password",
                  labelText:"Password",
                ),
            ),

                    TextButton(onPressed: (){}, child: Text("forget password ?")),
                    SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: () {
                      if(_formKey.currentState!.validate()){
                        signInWithEmailAndPassword();
                      }

                    } ,
                      child:isLoading?CircularProgressIndicator(color: Colors.white,)
                          :const Text("Log In"),
                      style: TextButton.styleFrom(
                        minimumSize:Size(140,50),
                        backgroundColor: Colors.black,
                      ),

                    ),
                    SizedBox(height: 20,),
                    Text("or login using",),
                    SizedBox(height: 20,),
                    Container(
                      child: Column(
                        children: [
                          IconButton(
                            icon: Image.asset('assets/images/google.png'),
                            iconSize: 50,
                            onPressed: authService.handleSignIn,
                          )
                        ],
                      ),
                    ),


                    SizedBox(height: 40,),
                    Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text("Dont't have an account ?"),
                            TextButton(onPressed: (){
                              Navigator.pushNamed(context, MyRoutes.signupRoute);
                            } ,child:Text("Sign Up")),
                          ] ,
                        )

                    )

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
