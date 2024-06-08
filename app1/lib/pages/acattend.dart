import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:Eventlyst/utils/routes.dart';

class acattend extends StatefulWidget {
  @override
  _acattendState createState() => _acattendState();
}

class _acattendState extends State<acattend> {
  late Future<List<Map<String, dynamic>>> _posts;

  @override
  void initState() {
    super.initState();
    _posts = fetchPosts();
  }

  Future<List<Map<String, dynamic>>> fetchPosts() async {
    try {
      // Get the current user ID
      String? userId = FirebaseAuth.instance.currentUser?.uid;

      if (userId != null) {
        // Get reference to Firestore collection
        CollectionReference<Map<String, dynamic>> registrationsCollection =
            FirebaseFirestore.instance.collection('event_registrations');

        // Fetch documents from the 'event_registrations' collection where user_id is equal to the current user's ID
        QuerySnapshot<Map<String, dynamic>> registrationsQuery =
            await registrationsCollection
                .where('user_id', isEqualTo: userId)
                .get();

        // Get a list of post IDs associated with the user's registrations
        List<String> postIds = registrationsQuery.docs
            .map((DocumentSnapshot<Map<String, dynamic>> doc) {
          return doc['post_id'] as String; // Explicitly cast to String
        }).toList();

        // Get reference to 'posts' collection
        CollectionReference<Map<String, dynamic>> postsCollection =
            FirebaseFirestore.instance.collection('posts');

        // Fetch documents from the 'posts' collection where the post ID is in the list obtained from registrations
        QuerySnapshot<Map<String, dynamic>> postsQuery = await postsCollection
            .where(FieldPath.documentId, whereIn: postIds)
            .get();

        // Convert each document to a map and return the list
        return postsQuery.docs
            .map((DocumentSnapshot<Map<String, dynamic>> doc) {
          return doc.data()!;
        }).toList();
      }

      return [];
    } catch (e) {
      print('Error fetching posts: $e');
      return [];
    }
  }

  Widget _buildImage(String imageUrl, Map<String, dynamic> post) {
    return InkWell(
      onTap: () {
        // Navigate to the desired page here
        Navigator.pushNamed(
          context,
          MyRoutes.showregisteredpostRoute,
          arguments: post,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          width: double.infinity,
          imageUrl,
          height: 200,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _posts,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No posts available.');
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> post = snapshot.data![index];
              String userId = post['user_id'] ?? '';

              return FutureBuilder<String?>(
                future: getUsernameFromUserId(userId),
                builder: (context, usernameSnapshot) {
                  if (usernameSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else if (usernameSnapshot.hasError) {
                    return Text('Error: ${usernameSnapshot.error}');
                  } else {
                    String? username = usernameSnapshot.data;
                    String title = post['title'] ?? '';
                    String description = post['description'] ?? '';
                    String venue = post['venue'] ?? '';
                    String imageUrl = post['image_url'] ?? '';

                    return Card(
                      elevation: 3,
                      margin: EdgeInsets.all(10),
                      child: SizedBox(
                        width: screenWidth > 600 ? 600 : double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                // CircleAvatar(
                                //   child: Image.asset(
                                //     "assets/images/profile.png",
                                //     width: screenWidth > 400
                                //         ? 70
                                //         : 35, // Increase size for tablets
                                //     height: screenWidth > 600 ? 70 : 35,
                                //   ),
                                //   radius: 20,
                                // ),
                                SizedBox(width: screenWidth > 400 ? 16 : 8),
                                // Expanded(
                                //   child: Container(
                                //     child: Column(
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.start,
                                //       children: [
                                //         Text(
                                //           '${username ?? "Unknown"}',
                                //           style: TextStyle(
                                //               fontWeight: FontWeight.bold,
                                //               fontSize:
                                //                   screenWidth > 600 ? 24 : 16),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                            if (imageUrl.isNotEmpty)
                              _buildImage(imageUrl, post),
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    title,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    description,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 8),
                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Free : Free',
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              fontSize:
                                                  screenWidth > 400 ? 18 : 15),
                                        ),
                                        SizedBox(
                                            width: screenWidth > 600
                                                ? 150.0
                                                : 100.0), // Adjust the spacing
                                        // ElevatedButton.icon(
                                        //   onPressed: () {
                                        //     // Navigator.pushNamed(
                                        //     //   context,
                                        //     //   MyRoutes.showpostRoute,
                                        //     //   arguments: post,
                                        //     // );
                                        //   },
                                        //   icon: Icon(
                                        //     Icons.bookmark_add_outlined,
                                        //     size: screenWidth > 600 ? 24 : 15,
                                        //   ),
                                        //   style: ElevatedButton.styleFrom(
                                        //     fixedSize: Size(
                                        //         screenWidth > 600 ? 180 : 135,
                                        //         30),
                                        //     shape: RoundedRectangleBorder(
                                        //       borderRadius:
                                        //           BorderRadius.circular(20),
                                        //     ),
                                        //   ),
                                        //   label: Text('Info'),
                                        // ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              );
            },
          );
        }
      },
    );
  }

  Future<String?> getUsernameFromUserId(String userId) async {
    try {
      // Assuming you have a 'users' collection in Firestore
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(userId)
          .get();

      if (userDoc.exists) {
        // If the document exists, return the username
        return userDoc['username'];
      } else {
        // If the document doesn't exist, handle it accordingly
        return null; // or return a default username or an error message
      }
    } catch (e) {
      print('Error fetching username: $e');
      return null; // Handle the error, return a default username, or an error message
    }
  }
}
