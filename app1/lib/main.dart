import 'package:Eventlyst/pages/Admin.dart';
import 'package:Eventlyst/pages/Feedback.dart';
import 'package:Eventlyst/pages/bookmark.dart';
import 'package:Eventlyst/pages/home_page.dart';
import 'package:Eventlyst/pages/intro_page.dart';
import 'package:Eventlyst/pages/login_page.dart';
import 'package:Eventlyst/pages/orgHome.dart';
import 'package:Eventlyst/pages/orgPage.dart';
import 'package:Eventlyst/pages/post_page.dart';
import 'package:Eventlyst/pages/profile.dart';
import 'package:Eventlyst/pages/reminder_page.dart';
import 'package:Eventlyst/pages/seacrh1.dart';
import 'package:Eventlyst/pages/settings.dart';
import 'package:Eventlyst/utils/routes.dart';
import 'package:Eventlyst/pages/signup_page.dart';
import 'package:Eventlyst/pages/showpost.dart';
import 'package:Eventlyst/pages/authPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Eventlyst/firebase_options.dart';
import 'package:provider/provider.dart';
// import 'package:Eventlyst/pages/profile.dart';

Future<void> main() async {
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
        MyRoutes.adminRoute: (context) => Myadmin(),
        MyRoutes.showpostRoute: (context) => showpost(),
        // MyRoutes.Orghome1Route: (context) => ProfilePage(),
      },
    );
  }
}
