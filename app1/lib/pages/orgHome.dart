import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:app1/utils/routes.dart';

class MyOrgHome extends StatelessWidget {
  const MyOrgHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("ORGANISATION"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
             children: <Widget>[
               SizedBox(height: 40,),
               Image.asset("assets/images/Schoool.png",height: 80,),
               Text("Yeshwantrao Chavan college of engineering",style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),),
                const Divider(),
           SizedBox(height: 12,),
               SingleChildScrollView(
                 child: IntrinsicHeight(
                   child: Row(
                     children: [SizedBox(width: 2,),
                       TextButton(onPressed: (){}, child: Text("Feed",style: TextStyle(fontSize: 20,color: Colors.black,),)),
                       VerticalDivider(color: Colors.black, thickness: 1,),
                       SizedBox(width: 10,),
                       TextButton(onPressed: (){}, child: Text("Department",style: TextStyle(fontSize: 20,color: Colors.black),)),
                       VerticalDivider(color: Colors.black, thickness: 1,),
                       SizedBox(width: 10,),
                       TextButton(onPressed: (){}, child: Text("Clubs",style: TextStyle(fontSize: 20,color: Colors.black),)),

                     ],
                   ),

                 ),
               ),

             ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15),
          child: GNav(
            gap: 12,
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.black,
            tabs: [
              GButton(onPressed: () {
                Navigator.pushNamed(context, MyRoutes.homeRoute,);
              }, icon: Icons.home,),
              GButton(onPressed: () {Navigator.pushNamed(context, MyRoutes.searchRoute);}, icon: Icons.search,),
              GButton(onPressed: () {Navigator.pushNamed(context, MyRoutes.postRoute);}, icon: Icons.post_add,),
              GButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.orgRoute,);
                }, icon: Icons.school,),
            ],
          ),
        ),
      ),
    );
  }
}
