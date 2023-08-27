// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class MyDrawer extends StatelessWidget {
//   const MyDrawer({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       backgroundColor: Colors.white,
//       child: Container(
//         child: ListView(
//           children: [
//             DrawerHeader(
//               padding: EdgeInsets.zero,
//               child: UserAccountsDrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Colors.black,
//                 ),
//                 accountName: Text("Pawan Balpande"),
//                 accountEmail: Text("pawanbalpande00@gmail.com"),
//                 currentAccountPicture: CircleAvatar(),
//               ),
//             ),
//             SizedBox(height: 430),
//             ListTile(
//               title: Text(
//                 "Bookmark",
//                 textScaleFactor: 1.1,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//             Center(
//               child: ListTile(
//                 title: Text(
//                   "Feedback",
//                   textScaleFactor: 1.1,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w700,
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//             ),
//             ListTile(
//               title: Text(
//                 "Settings",
//                 textScaleFactor: 1.1,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//             ListTile(
//               title: Text(
//                 "Sign Out",
//                 textScaleFactor: 1.1,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontSize: 20,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
