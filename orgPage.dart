import 'package:app1/pages/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class orgLogin extends StatefulWidget {
  const orgLogin({super.key});

  @override
  State<orgLogin> createState() => _orgLoginState();
}

class _orgLoginState extends State<orgLogin> {
final _formfield = GlobalKey<FormState>();
final emailcontroller = TextEditingController();
final passcontroller = TextEditingController();
bool passToggle = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:Text("ORGANISATION"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20 ,vertical: 60),

          child: Form(
            key: _formfield,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Center(child: Text("ORGANISATION",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w300,height:2),)),
                Text("REGISTRATION",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w300,),),
                SizedBox(height: 120,),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller : emailcontroller,
                  decoration: InputDecoration(
                    hintText: "Enter your Organisation Email id",
                    labelText: "Email Id",
                    border: OutlineInputBorder(),

                  ),
                  validator: (value){
                    if(value!.isEmpty){
                      return "Enter Email";
                    }
                    bool emailValid = RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#!$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value);
                    if(!emailValid){
                      return "Enter Valid Email";
                    }
                  },
                ),
                SizedBox(height: 30,),
                TextFormField(
                keyboardType: TextInputType.visiblePassword,
                controller: passcontroller,
                 obscureText: passToggle,
                 decoration: InputDecoration(
                   hintText: "Enter your password",
                   labelText: "Password",
                  border: OutlineInputBorder(),
                   suffix: InkWell(
                     onTap: (){
                       setState(() {
                         passToggle=!passToggle;
                       });
                     },
                   child: Icon(passToggle? Icons.visibility : Icons.visibility_off),
                   ),
                 ),
                  validator:(value){
                  if(value!.isEmpty){
                    return "Enter Password";
                  }
                  else if(passcontroller.text.length<6){
                    return "Password length should be more than 6 charachter";
                  }
                  },
            ),
                SizedBox(height: 50,),
                InkWell(
                  onTap: (){
                    if(_formfield.currentState!.validate()){
                      Navigator.pushNamed(context, MyRoutes.Orghome1Route);
                      emailcontroller.clear();
                      passcontroller.clear();

                    }
                  },
                  child: Container(
                    height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    child: Center(
                      child: Text("LogIn",style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),),
                    ),
                  ),
                ),
               SizedBox(height: 40,),

                      Row(
                         children: [
                           Text("login as a Admin :"),
                           TextButton(onPressed: (){Navigator.pushNamed(context, MyRoutes.adminRoute);}, child: Text("Admin Login",style: TextStyle(fontSize: 17),)),
                         ],
                       ),



               SizedBox(height: 20,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Note",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 19),),
                    SizedBox(height: 10,),
                    Text("You can follow the events related to your organisation so that you can stay up to date with your organisation  events . ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w300,fontSize: 16),),
                ],),
              ],
            ),
          ),
        ),
      ),
    );
  }
}