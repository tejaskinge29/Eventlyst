import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:app1/pages/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:app1/pages/auth_service/auth_service.dart';

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

  createUserWithEmailAndPassword()async{
    try {
      setState(() {
        isLoading = true;
      });
       await FirebaseAuth.instance.createUserWithEmailAndPassword(
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
      if (e.code == 'weak-password') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("The password provided is too weak."),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Wrong password provided for the user."),
          ),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
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
                    Text("SIGNUP",style: TextStyle(fontSize: 30,fontWeight:FontWeight.w200),),
                    SizedBox(height: 8,),

                    Text("Please sign up to continue !",style: TextStyle(fontSize: 15,fontWeight:FontWeight.w600),),
                    SizedBox(height: 5,),
                    TextFormField(
                      controller: _name,
                      validator: (text){
                        if (text == null || text.isEmpty){
                          return "email is empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText:"Enter Name",
                        labelText:"Full Name",
                      ),
                    ),
                    SizedBox(height: 30,),
                    TextFormField(
                      controller: _username,
                      validator: (text){
                        if (text == null || text.isEmpty){
                          return "Username is empty";
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
                      controller: _email,
                      validator: (text){
                        if (text == null || text.isEmpty){
                          return "Email is empty";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText:"Enter Email",
                        labelText:"Email",
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
                    ElevatedButton (onPressed:(){
                      if(_formKey.currentState!.validate()){
                        createUserWithEmailAndPassword();
                      }
                    } ,
                      child:isLoading?CircularProgressIndicator(color: Colors.white,)
                          :const Text("Register"),
                      style: TextButton.styleFrom(
                        minimumSize:Size(140,50),
                        backgroundColor: Colors.black,
                      ),

                    ),
                    SizedBox(height: 10,),
                    Text("or Sign up using",),
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


                    SizedBox(height: 15,),
                    Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text("Already have an account ?"),
                            TextButton(onPressed: (){
                              Navigator.pushNamed(context, MyRoutes.loginRoute);
                            } ,child:Text("Log in")),
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
