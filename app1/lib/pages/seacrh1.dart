import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:Eventlyst/utils/routes.dart';

class Search_Page extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<Search_Page> {
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];

  @override
  void dispose() {
    // Clear search results when the state is disposed
    searchResults.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Search"),
        actions: <Widget>[],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              controller: searchController,
              onChanged: (query) {
                filterPosts(query);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13.0),
                ),
                filled: true,
                hintText: 'Search',
                fillColor: Color.fromARGB(217, 255, 255, 255),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> post = searchResults[index];
                return buildPostCard(context, post);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: (MediaQuery.of(context).size.height * 0.1),
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GNav(
            gap: 12,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.black,
            tabs: [
              GButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    MyRoutes.homeRoute,
                  );
                },
                icon: Icons.home,
              ),
              GButton(
                onPressed: () {},
                icon: Icons.search,
              ),
              GButton(
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.postRoute);
                },
                icon: Icons.post_add,
              ),
              GButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    MyRoutes.orgRoute,
                  );
                },
                icon: Icons.school,
              ),
            ],
          ),
        ),
      ),
    );
  }

// code refered fromm the firepostdiaply page

  Widget buildPostCard(BuildContext context, Map<String, dynamic> post) {
    double screenWidth = MediaQuery.of(context).size.width;

    // Function to get username from userId
    Future<String?> getUsernameFromUserId(String userId) async {
      try {
        DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
            .instance
            .collection('users')
            .doc(userId)
            .get();

        if (userDoc.exists) {
          return userDoc['username'];
        } else {
          return null;
        }
      } catch (e) {
        print('Error fetching username: $e');
        return null;
      }
    }

    return Card(
      elevation: 3,
      margin: EdgeInsets.all(10),
      child: SizedBox(
        width: screenWidth > 600 ? 600 : double.infinity,
        child: FutureBuilder<String?>(
          future: getUsernameFromUserId(post['user_id'] ?? ''),
          builder: (context, usernameSnapshot) {
            if (usernameSnapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (usernameSnapshot.hasError) {
              return Text('Error: ${usernameSnapshot.error}');
            } else {
              String? username = usernameSnapshot.data;
              String postId = post['post_id'] ?? '';
              return Column(
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${username ?? "Unknown"}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth > 600 ? 24 : 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: screenWidth > 600 ? 16 : 8),
                  if (post['image_url'] != null)
                    Image.network(
                      post['image_url'],
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post['title'] ?? 'No title',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 2),
                        Text(
                          post['description'] ?? 'No description',
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
                                    fontSize: screenWidth > 600 ? 18 : 15),
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
                                  size: screenWidth > 600 ? 24 : 15,
                                ),
                                style: ElevatedButton.styleFrom(
                                  fixedSize:
                                      Size(screenWidth > 600 ? 180 : 135, 30),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                label: Text('Register now'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void filterPosts(String query) async {
    try {
      CollectionReference<Map<String, dynamic>> postsCollection =
          FirebaseFirestore.instance.collection('posts');

      QuerySnapshot<Map<String, dynamic>> postsQuery = await postsCollection
          .where('title', isGreaterThanOrEqualTo: query)
          .where('title', isLessThan: query + 'z') // Ensure partial matching
          .get();

      setState(() {
        searchResults =
            postsQuery.docs.map((DocumentSnapshot<Map<String, dynamic>> doc) {
          return doc.data()!;
        }).toList();
      });
    } catch (e) {
      print('Error filtering posts: $e');
    }
  }
}
