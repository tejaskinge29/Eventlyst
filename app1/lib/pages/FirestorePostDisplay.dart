import 'package:flutter/material.dart';
import 'package:Eventlyst/utils/routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import 'package:Eventlyst/pages/showpost.dart';
import 'package:Eventlyst/pages/auth_service/auth_service.dart';

class FirestorePostDisplay extends StatefulWidget {
  @override
  _FirestorePostDisplayState createState() => _FirestorePostDisplayState();
}

class _FirestorePostDisplayState extends State<FirestorePostDisplay> {
  bool isStarFilled = false;
  late String userId;
  late Future<List<Map<String, dynamic>>> _posts;
  @override
  void initState() {
    super.initState();
    _posts = fetchPosts();
    fetchUserId(); // Fetch user ID when the widget initializes
  }

  // Method to fetch user ID
  Future<void> fetchUserId() async {
    AuthService authService = AuthService();
    userId = (await authService.getUserIdFromSharedPreferences()) ?? '';
    setState(
        () {}); // Update the state to rebuild the widget with the fetched userId
  }

  /// Method to toggle save/remove event
  Future<void> toggleSaveEvent(String postId, bool isSaved) async {
    try {
      // String userId = 't8bU36fIICaxzFrpm2sIy0EhLVk2'; // Get current user's ID
      CollectionReference<Map<String, dynamic>> savedEventsRef =
          FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('saved_events');

      // Check if the post exists in the user's saved events collection
      DocumentSnapshot<Map<String, dynamic>> savedPostDoc =
          await savedEventsRef.doc(postId).get();

      if (savedPostDoc.exists) {
        // If the post exists, remove it from saved events and update the selected state
        await savedEventsRef.doc(postId).delete();
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .update({'isSaved': false});
        print('Event removed successfully');

        // Update the isStarFilled state to false
        setState(() {
          isStarFilled = false;
        });
      } else {
        // If the post doesn't exist, save it and update the selected state
        await savedEventsRef.doc(postId).set({
          // Store event details here
          'post_id': postId,
        });
        await FirebaseFirestore.instance
            .collection('posts')
            .doc(postId)
            .update({'isSaved': true});
        print('Event saved successfully');

        // Update the isStarFilled state to true
        setState(() {
          isStarFilled = true;
        });
      }
    } catch (e) {
      print('Error toggling save event: $e');
    }
  }

// Method to check if the post is saved in the user's saved events collection
  Future<bool> checkIfPostIsSaved(String postId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> savedPostDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .collection('saved_events')
              .doc(postId)
              .get();
      return savedPostDoc.exists;
    } catch (e) {
      print('Error checking if post is saved: $e');
      return false;
    }
  }
  // // Save event to Firestore
  // Future<void> saveEvent(String postId) async {
  //   try {
  //     // String userId = 't8bU36fIICaxzFrpm2sIy0EhLVk2'; // Get current user's ID
  //     await FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userId)
  //         .collection('saved_events')
  //         .doc(postId)
  //         .set({
  //       // Store event details here
  //       'post_id': postId,
  //     });
  //     print('Event saved successfully');
  //   } catch (e) {
  //     print('Error saving event: $e');
  //   }
  // }

  // fetching postdata from firstore with images
  Future<List<Map<String, dynamic>>> fetchPosts() async {
    try {
      // Get reference to Firestore collection
      CollectionReference<Map<String, dynamic>> postsCollection =
          FirebaseFirestore.instance.collection('posts');

      // Get the current date
      DateTime currentDate = DateTime.now();

      // Fetch documents from the collection related to the current date
      QuerySnapshot<Map<String, dynamic>> postsQuery = await postsCollection
          .where('selected_date', isGreaterThanOrEqualTo: currentDate)
          .get();

      // Convert each document to a map with 'post_id' field and return the list
      List<Map<String, dynamic>> posts = [];
      await Future.forEach(postsQuery.docs,
          (DocumentSnapshot<Map<String, dynamic>> doc) async {
        Map<String, dynamic> data = doc.data()!;
        data['post_id'] = doc.id; // Add 'post_id' field with the document ID
        // Check if the post is saved by the user
        bool isSaved = await checkIfPostIsSaved(doc.id);
        data['isStarFilled'] =
            isSaved; // Set the 'isStarFilled' field based on whether the post is saved
        posts.add(data);
      });

      return posts;
    } catch (e) {
      print('Error fetching posts: $e');
      return [];
    }
  }

  Widget _buildImage(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        width: double.infinity,
        imageUrl,
        height: 200,
        fit: BoxFit.cover,
      ),
    );
  }
// get username from user id

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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return FutureBuilder<List<Map<String, dynamic>>>(
        future: _posts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
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
                        return Container();
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
                                    CircleAvatar(
                                      child: Image.asset(
                                        "assets/images/profile.png",
                                        width: screenWidth > 600
                                            ? 70
                                            : 35, // Increase size for tablets
                                        height: screenWidth > 600 ? 70 : 35,
                                      ),
                                      radius: 20,
                                    ),
                                    SizedBox(width: screenWidth > 600 ? 16 : 8),
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${username ?? "Unknown"}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: screenWidth > 600
                                                      ? 24
                                                      : 16),
                                            ),
                                            // Text(
                                            //   '04 April',
                                            //   style: TextStyle(
                                            //       fontWeight: FontWeight.normal,
                                            //       fontSize:
                                            //           screenWidth > 600 ? 14 : 10),
                                            // ),
                                            Text(
                                              'Post ID:  ${post['post_id']}', // Display the post ID
                                              style: TextStyle(
                                                fontWeight: FontWeight.normal,
                                                fontSize:
                                                    screenWidth > 600 ? 14 : 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        width: screenWidth > 600 ? 16 : 10),
                                    // In your build method, set the initial state of isStarFilled based on the retrieved values
                                    IconButton(
                                      iconSize: screenWidth > 600 ? 40 : 30,
                                      color: Colors.yellow,
                                      icon: (post['isStarFilled'] ?? false)
                                          ? Icon(Icons.star,
                                              color: Colors.yellow)
                                          : Icon(Icons.star_border_outlined),
                                      onPressed: () {
                                        toggleSaveEvent(post['post_id'],
                                            post['isStarFilled'] ?? false);
                                        setState(() {
                                          post['isStarFilled'] =
                                              !(post['isStarFilled'] ?? false);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                                if (imageUrl.isNotEmpty) _buildImage(imageUrl),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                  fontSize: screenWidth > 600
                                                      ? 18
                                                      : 15),
                                            ),
                                            SizedBox(
                                                width: screenWidth > 600
                                                    ? 150.0
                                                    : 100.0), // Adjust the spacing
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                Navigator.pushNamed(
                                                  context,
                                                  MyRoutes.showpostRoute,
                                                  arguments: post,
                                                );
                                              },
                                              icon: Icon(
                                                Icons.bookmark_add_outlined,
                                                size:
                                                    screenWidth > 600 ? 24 : 15,
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                fixedSize: Size(
                                                    screenWidth > 600
                                                        ? 180
                                                        : 135,
                                                    30),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                              ),
                                              label: Text('Register now'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Text('Venue: $venue'),
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
            } //else here
          } else {
            return Container(); // Show nothing while waiting for data
          }
        });
  }
}
