import 'package:app1/utils/routes.dart';
import 'package:flutter/material.dart';
 class LoginPage extends StatefulWidget {
   const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
final _formKey = GlobalKey<FormState>();
moveToHome(BuildContext context){

}

   @override
   Widget build(BuildContext context) {
     return Material(
       child:SingleChildScrollView(
         child: Column(
           children: [
             Text("LOGIN",
             style: TextStyle(
               height: 7,
               fontSize: 30,
               fontWeight: FontWeight.w300,
             ),
             ),
             Text("Welcome !",
               style: TextStyle(
                 height: 3,
                 fontSize: 25,
                 fontWeight: FontWeight.w800,
               ),
             ),
             Text("Please sign in to continue !",
               style: TextStyle(
                 height: 2,
                 fontSize: 17,
                 fontWeight: FontWeight.w500,
               ),
             ),
           SizedBox(height:40,),
           Padding(
     padding: const EdgeInsets.symmetric(vertical: 20.0 , horizontal: 30.0),
     child: Form(
         key: _formKey,
         child: Column(
         children: [
         TextFormField(
         decoration: InputDecoration(
         hintText:"Enter Username",
         labelText:"Username",
         ),
         
         ),
         ],
             ),
     )
         ),
             SizedBox(height:10,),
             Padding(
                 padding: const EdgeInsets.symmetric(vertical: 20.0 , horizontal: 30.0),
                 child: Column(
                   children: [
                   TextFormField(
                   obscureText:true,
                   decoration: InputDecoration(
                     hintText:"Enter Password",
                     labelText:"Password",
                   ),
                   ),
                   ],
                 )
             ),
           TextButton(onPressed: (){}, child: Text("forget password ?")),


           SizedBox(height: 20),



           ElevatedButton (onPressed:(){
            Navigator.pushNamed(context, MyRoutes.homeRoute);

          } , child: Text("LogIn"),
            style: TextButton.styleFrom(
                minimumSize:Size(140,50),
              backgroundColor: Colors.black,
            ),

           ),


             SizedBox(height: 30,),
             Text("or login using",),
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


             SizedBox(height: 60,),
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
     );


   }
}
