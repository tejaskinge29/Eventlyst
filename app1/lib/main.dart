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
import 'package:Eventlyst/pages/showregisteredpost.dart';
import 'package:Eventlyst/pages/authPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:Eventlyst/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:Eventlyst/user_data_provider.dart';
// import 'package:Eventlyst/pages/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> determineInitialRoute() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  return isLoggedIn ? MyRoutes.homeRoute : '/';
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Determine the initial route
  String initialRoute = await determineInitialRoute();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserIdProvider()),
        // You can directly use SharedPreferences where needed
        Provider<SharedPreferences>.value(
            value: await SharedPreferences.getInstance()),
      ],
      child: MyApp(initialRoute: initialRoute),
    ),
  );
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});
  final String initialRoute;
  const MyApp({Key? key, required this.initialRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access SharedPreferences instance
    SharedPreferences prefs = Provider.of<SharedPreferences>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
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
        MyRoutes.showregisteredpostRoute: (context) => showregisteredpost(
            post: ModalRoute.of(context)?.settings.arguments
                as Map<String, dynamic>),
        // MyRoutes.Orghome1Route: (context) => ProfilePage(),
      },
    );
  }
}
