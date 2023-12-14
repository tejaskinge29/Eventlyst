import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Eventlyst/utils/routes.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class Mypost extends StatefulWidget {
  const Mypost({Key? key}) : super(key: key);

  @override
  State<Mypost> createState() => _MyPostState();
}

class _MyPostState extends State<Mypost> {
  XFile? _imageFile;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController venueController = TextEditingController();

  Future<User?> getCurrentUser() async {
    return FirebaseAuth.instance.currentUser;
  }

  // Function to pick an image from the gallery
  void _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

// Define the method to upload data to Firebase Cloud Storage and Firestore
  Future<void> uploadDataToCloud(
      String title, String description, String venue) async {
    try {
      if (_imageFile != null) {
        final Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('post_images/${DateTime.now().millisecondsSinceEpoch}');
        final UploadTask uploadTask =
            storageReference.putFile(File(_imageFile!.path));
        final TaskSnapshot taskSnapshot = await uploadTask;
        final imageUrl = await taskSnapshot.ref.getDownloadURL();

        // Store post data in Firestore
        final postDocRef =
            await FirebaseFirestore.instance.collection('posts').add({
          'title': title,
          'description': description,
          'venue': venue,
          'image_url': imageUrl, // Store the image URL
        });

        print('Post uploaded successfully with ID: ${postDocRef.id}');
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error uploading post: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post"),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
          child: Column(
            children: [
              Align(
                alignment: AlignmentDirectional(-1.00, 0.00),
                child: Text(
                  'Event Title',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: 'Enter event title',
                  border: OutlineInputBorder(
                    // Customize the border size here
                    borderRadius: BorderRadius.circular(12.0), // Border radius
                    borderSide: BorderSide(
                      color: Colors.black, // Border color
                      width: 1.0, // Border width
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Align(
                alignment: AlignmentDirectional(-1.00, 0.00),
                child: Text(
                  'Event Description',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                  labelText: 'Enter event description ',
                  border: OutlineInputBorder(
                    // Customize the border size here
                    borderRadius: BorderRadius.circular(12.0), // Border radius
                    borderSide: BorderSide(
                      color: Colors.black, // Border color
                      width: 1.0, // Border width
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Align(
                alignment: AlignmentDirectional(-1.00, 0.00),
                child: Text(
                  'Event Venue',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              TextField(
                controller: venueController,
                decoration: InputDecoration(
                  labelText: 'Enter a venue ',
                  border: OutlineInputBorder(
                    // Customize the border size here
                    borderRadius: BorderRadius.circular(12.0), // Border radius
                    borderSide: BorderSide(
                      color: Colors.black, // Border color
                      width: 1.0,
                      // Border width
                    ),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Align(
                alignment: AlignmentDirectional(-1.00, 0.00),
                child: Text(
                  'Select Image',
                  style: TextStyle(
                    fontFamily: 'Plus Jakarta Sans',
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              // Image preview
              if (_imageFile != null)
                // Image.network(
                //   'https://upload.wikimedia.org/wikipedia/commons/thumb/4/42/Temp_plate.svg/601px-Temp_plate.svg.png', // Provide the URL of the image
                //   height: 200, // Set the desired height
                //   width: 200, // Set the desired width
                // )
                Image.file(
                  File(_imageFile!
                      .path), // Use null check operator (!) to access path
                  height: 200, // Set the desired height
                  width: 200, // Set the desired width
                )
              else
                Container(), // Hide the image preview if no image is selected
              ElevatedButton(
                onPressed: _pickImage,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.white), // Set button background color
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjust border radius as needed
                      side: BorderSide(
                          color: Colors.black,
                          width: 1.0), // Set border color and width
                    ),
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(
                        color: Colors
                            .transparent), // Set text color to transparent
                  ),
                ),
                child: Icon(
                  Icons.cloud_upload,
                  color: Colors.black, // Set icon color to black
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              ElevatedButton(
                onPressed: () async {
                  final title = titleController.text;
                  final description = descriptionController.text;
                  final venue = venueController.text;

                  if (title.isEmpty || description.isEmpty || venue.isEmpty) {
                    // Show an error message if any of the fields are empty
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill in all fields'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  // Get the current authenticated user
                  User? currentUser = await getCurrentUser();

                  if (currentUser != null) {
                    if (_imageFile != null) {
                      final Reference storageReference =
                          FirebaseStorage.instance.ref().child(
                              'post_images/${DateTime.now().millisecondsSinceEpoch}');
                      final UploadTask uploadTask =
                          storageReference.putFile(File(_imageFile!.path));
                      final TaskSnapshot taskSnapshot = await uploadTask;
                      final imageUrl = await taskSnapshot.ref.getDownloadURL();

                      // Store post data in Firestore with the image URL and user information
                      await FirebaseFirestore.instance.collection('posts').add({
                        'title': title,
                        'description': description,
                        'venue': venue,
                        'image_url': imageUrl,
                        'user_id': currentUser.uid, // Add user ID to the post
                      });

                      // Show a success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Post uploaded successfully'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    } else {
                      // Store post data in Firestore without an image URL and with user information
                      await FirebaseFirestore.instance.collection('posts').add({
                        'title': title,
                        'description': description,
                        'venue': venue,
                        'user_id': currentUser.uid, // Add user ID to the post
                      });

                      // Show a success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Post uploaded successfully (without an image)'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  } else {
                    // User is not authenticated, handle accordingly
                    // You might want to redirect the user to the login screen
                  }
                },
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(140, 50)),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.black),
                ),
                child: Text(
                  "POST",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      // Navigation bar
      bottomNavigationBar: Container(
        height: (MediaQuery.of(context).size.height * 0.1),
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: GNav(
            gap: 12,
            // backgroundColor: Colors.black,
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
                onPressed: () {
                  Navigator.pushNamed(context, MyRoutes.searchRoute);
                },
                icon: Icons.search,
              ),
              GButton(
                onPressed: () {},
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
}
