import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Eventlyst/utils/routes.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';

class Mypost extends StatefulWidget {
  const Mypost({Key? key}) : super(key: key);

  @override
  State<Mypost> createState() => _MyPostState();
}

class _MyPostState extends State<Mypost> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
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

// logic to select date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

// logic for selecting Time
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  String convertTimeOfDayToString(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dateTime = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final formattedTime = DateFormat('hh:mm a').format(dateTime);
    return formattedTime;
  }

  // Define the method to upload data to Firebase Cloud Storage and Firestore
  Future<void> uploadDataToCloud(String title, String description, String venue,
      BuildContext context) async {
    try {
      if (_imageFile != null) {
        final Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('post_images/${DateTime.now().millisecondsSinceEpoch}');
        final UploadTask uploadTask =
            storageReference.putFile(File(_imageFile!.path));
        final TaskSnapshot taskSnapshot = await uploadTask;
        final imageUrl = await taskSnapshot.ref.getDownloadURL();

        if (selectedDate == null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please select a date'),
              duration: Duration(seconds: 2),
            ),
          );
          return;
        }

        // Convert TimeOfDay to String
        final selectedTimeString =
            selectedTime != null ? convertTimeOfDayToString(selectedTime!) : '';

        // Store post data in Firestore
        final postDocRef =
            await FirebaseFirestore.instance.collection('posts').add({
          'title': title,
          'description': description,
          'venue': venue,
          'image_url': imageUrl, // Store the image URL
          'selected_date':
              selectedDate != null ? Timestamp.fromDate(selectedDate!) : null,
          'selected_time': selectedTimeString,
          'timestamp': FieldValue.serverTimestamp(),
        });

        // Get the ID of the created document
        final postId = postDocRef.id;

        // Update the post with its own ID
        await postDocRef.update({'post_id': postId});

        print('Post uploaded successfully with ID: $postId');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Post uploaded successfully with ID: $postId'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        final selectedTimeString =
            selectedTime != null ? convertTimeOfDayToString(selectedTime!) : '';
        // Store post data in Firestore without an image URL and with user information
        await FirebaseFirestore.instance.collection('posts').add({
          'title': title,
          'description': description,
          'venue': venue,
          'selected_date': selectedDate,
          'selected_time': selectedTimeString,
          'user_id':
              FirebaseAuth.instance.currentUser?.uid, // Add user ID to the post
        });
      }
      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Post uploaded successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      // Handle the error
      print('Error uploading post: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload the post'),
          duration: Duration(seconds: 2),
        ),
      );
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
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
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
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
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
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 1.0,
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
                  'Event Time',
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
              TextFormField(
                readOnly: true,
                onTap: () => _selectTime(context),
                decoration: InputDecoration(
                  labelText: 'Select Time',
                  suffixIcon: Icon(Icons.access_time),
                ),
                controller: selectedTime != null
                    ? TextEditingController(
                        text: '${selectedTime!.format(context)}',
                      )
                    : null,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              Align(
                alignment: AlignmentDirectional(-1.00, 0.00),
                child: Text(
                  'Event Date',
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
              TextFormField(
                readOnly: true,
                onTap: () => _selectDate(context),
                decoration: InputDecoration(
                  labelText: 'Select Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                controller: selectedDate != null
                    ? TextEditingController(
                        text: '${selectedDate!.toLocal()}'.split(' ')[0],
                      )
                    : null,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
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
              if (_imageFile != null)
                Image.file(
                  File(_imageFile!.path),
                  height: 200,
                  width: 200,
                )
              else
                Container(),
              ElevatedButton(
                onPressed: _pickImage,
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                  ),
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                child: Icon(
                  Icons.cloud_upload,
                  color: Colors.black,
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
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please fill in all fields'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                    return;
                  }

                  User? currentUser = await getCurrentUser();

                  if (currentUser != null) {
                    await uploadDataToCloud(title, description, venue, context);
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
