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
import 'package:Eventlyst/user_data_provider.dart';
// import 'package:Eventlyst/pages/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserIdProvider()),
        Provider<SharedPreferences>.value(
          value: await SharedPreferences.getInstance(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    // Access SharedPreferences instance
    SharedPreferences prefs = Provider.of<SharedPreferences>(context);

    // Check if the user is already logged in
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    // Determine the initial route based on the login status
    String initialRoute = isLoggedIn ? MyRoutes.homeRoute : '/';

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
        MyRoutes.showpostRoute: (context) => showpost(
            post: ModalRoute.of(context)?.settings.arguments
                as Map<String, dynamic>),
        // MyRoutes.Orghome1Route: (context) => ProfilePage(),
      },
    );
  }
}
