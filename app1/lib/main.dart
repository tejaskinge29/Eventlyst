import 'package:app1/pages/Feedback.dart';
import 'package:app1/pages/bookmark.dart';
import 'package:app1/pages/home_page.dart';
import 'package:app1/pages/intro_page.dart';
import 'package:app1/pages/login_page.dart';
import 'package:app1/pages/orgHome.dart';
import 'package:app1/pages/orgPage.dart';
import 'package:app1/pages/post_page.dart';
import 'package:app1/pages/profile.dart';
import 'package:app1/pages/reminder_page.dart';
import 'package:app1/pages/seacrh1.dart';
import 'package:app1/pages/settings.dart';
import 'package:app1/utils/routes.dart';
import 'package:app1/pages/signup_page.dart';
import 'package:flutter/material.dart';
// import 'package:app1/pages/profile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        "/": (context) => IntroPage(),
        MyRoutes.loginRoute: (context) => LoginPage(),
        MyRoutes.homeRoute: (context) => HomePage(),
        MyRoutes.signupRoute: (context) => SignupPage(),
        MyRoutes.orgRoute: (context) => orgLogin(),
        MyRoutes.orghomeRoute: (context) => MyOrgHome(),
        MyRoutes.postRoute: (context) => Mypost(),
        MyRoutes.remRoute: (context) => Myreminder(),
        MyRoutes.BookmarkRoute: (context) => MyBookmark(),
        MyRoutes.settingRoute: (context) => Mysettings(),
        MyRoutes.FeedbackRoute: (context) => Myfeedback(),
        MyRoutes.searchRoute: (context) => Search_Page(),
        MyRoutes.profileRoute: (context) => ProfilePage(),
      },
    );
  }
}
