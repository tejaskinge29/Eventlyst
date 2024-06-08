import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/routes.dart';
import 'auth_service/auth_service.dart';

class MyBookmark extends StatefulWidget {
  const MyBookmark({Key? key});

  @override
  State<MyBookmark> createState() => _MyBookmarkState();
}

class _MyBookmarkState extends State<MyBookmark> {
  late List<Map<String, dynamic>> _savedPosts = [];
  late String userId;
  late bool isStarFilled = false;

  @override
  void initState() {
    super.initState();
    fetchSavedPosts();
    fetchUserId();
  }

  Future<void> fetchSavedPosts() async {
    try {
      AuthService authService = AuthService();
      String? userId = await authService.getUserIdFromSharedPreferences();
      if (userId != null && userId.isNotEmpty) {
        QuerySnapshot<Map<String, dynamic>> savedEventsQuery =
            await FirebaseFirestore.instance
                .collection('users')
                .doc(userId)
                .collection('saved_events')
                .get();

        List<String> savedPostIds = savedEventsQuery.docs
            .map((doc) => doc['post_id'].toString())
            .toList();

        // Fetch saved posts based on the saved post IDs
        QuerySnapshot<Map<String, dynamic>> postsQuery = await FirebaseFirestore
            .instance
            .collection('posts')
            .where(FieldPath.documentId, whereIn: savedPostIds)
            .get();

        setState(() {
          _savedPosts = postsQuery.docs.map((doc) => doc.data()).toList();
        });
      }
    } catch (e) {
      print('Error fetching saved posts: $e');
    }
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Bookmark"),
        backgroundColor: Colors.black,
      ),
      body: _savedPosts.isEmpty
          ? Center(
              child: Text('No saved posts available.'),
            )
          : ListView.builder(
              itemCount: _savedPosts.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> post = _savedPosts[index];

                return GestureDetector(
                  onTap: () {
                    // Navigate to specific post page using post ID
                    Navigator.pushNamed(
                      context,
                      MyRoutes.showpostRoute,
                      arguments: post,
                    );
                  },
                  child: Card(
                    elevation: 3,
                    margin: EdgeInsets.all(10),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width > 600
                          ? 600
                          : double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Display post image
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                post['image_url'] ?? '',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Display post title
                                  Text(
                                    post['title'] ?? '',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  // Display post description
                                  Text(
                                    post['description'] ?? '',
                                    style: TextStyle(
                                      fontSize: 16,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: 10),
                                  // Add star icon button below post details
                                  // IconButton(
                                  //   iconSize: screenWidth > 600 ? 40 : 30,
                                  //   color: Colors.yellow,
                                  //   icon: isStarFilled
                                  //       ? Icon(Icons.star, color: Colors.yellow)
                                  //       : Icon(Icons.star_border_outlined),
                                  //   onPressed: () {
                                  //     toggleSaveEvent(
                                  //         post['post_id'], isStarFilled);
                                  //     setState(() {
                                  //       isStarFilled = !isStarFilled;
                                  //     });
                                  //   },
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
