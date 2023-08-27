import 'package:app1/pages/Admin.dart';
import 'package:app1/pages/Feedback.dart';
import 'package:app1/pages/bookmark.dart';
import 'package:app1/pages/home_page.dart';
import 'package:app1/pages/intro_page.dart';
import 'package:app1/pages/login_page.dart';
import 'package:app1/pages/orgHome.dart';
import 'package:app1/pages/orgPage.dart';
import 'package:app1/pages/post_page.dart';
import 'package:app1/pages/profile.dart';
import 'package:app1/pages/profile_org.dart';
import 'package:app1/pages/reminder_page.dart';
import 'package:app1/pages/seacrh1.dart';
import 'package:app1/pages/settings.dart';
import 'package:app1/pages/routes.dart';
import 'package:app1/pages/signup_page.dart';
import 'package:app1/pages/authPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../pages/firebase_options.dart';

Future<void> main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/":(context)=> HomePage(),
        MyRoutes.loginRoute:(context)=> LoginPage(),
        MyRoutes.homeRoute:(context)=> HomePage(),
        MyRoutes.signupRoute:(context)=>SignupPage(),
        MyRoutes.orgRoute:(context)=>orgLogin(),
        MyRoutes.orghomeRoute:(context)=>MyOrgHome(),
        MyRoutes.postRoute:(context)=>Mypost(),
        MyRoutes.remRoute:(context)=>Myreminder(),
        MyRoutes.BookmarkRoute:(context)=>MyBookmark(),
        MyRoutes.settingRoute:(context)=>Mysettings(),
        MyRoutes.FeedbackRoute:(context)=>Myfeedback(),
        MyRoutes.searchRoute:(context)=>Search_Page(),
        MyRoutes.profileRoute:(context)=>ProfileApp(),
        MyRoutes.adminRoute:(context)=>Myadmin(),
        MyRoutes.Orghome1Route:(context)=>ProfilePage(),
      },
    );

  }
}
