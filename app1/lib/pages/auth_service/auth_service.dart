import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Eventlyst/utils/routes.dart';
import 'package:Eventlyst/user_data_provider.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

// Future<User?> signInWithGoogle(BuildContext context) async

  Future<User?> signInWithGoogle(BuildContext context) async {
    try {
      // Trigger the Google Sign In process
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();

      // If the user cancels the sign-in process, return null
      if (googleSignInAccount == null) {
        return null;
      }

      // Obtain the GoogleSignInAuthentication object
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      // Create a new credential using the GoogleSignInAuthentication object
      final OAuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      // Sign in to Firebase with the Google credential
      UserCredential authResult =
          await _auth.signInWithCredential(googleCredential);

      // Get the signed-in user
      User? user = authResult.user;

      // Check if the user already exists in Firestore
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user!.uid)
          .get();

      // If the user doesn't exist, create a new user document in Firestore
      if (!userDoc.exists) {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': user.displayName,
          'email': user.email,
          'userId': user.uid,
          // Add other user data fields as needed.
        });
      }
      String username = userDoc['name'];
      // String email = userDoc['email'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userId', user.uid);
      await prefs.setString('email', userDoc['email']);
      await prefs.setString('username', username);
      // Use the provided context for navigation
      Navigator.pushReplacementNamed(
        context,
        MyRoutes.homeRoute,
        arguments: {'userDoc': userDoc},
      );

      return user;
    } catch (error) {
      print('Google Sign In Error: $error');

      // Print specific error message (if available)
      if (error is FirebaseAuthException) {
        print('Firebase Auth Error Code: ${error.code}');
        print('Firebase Auth Error Message: ${error.message}');
      }

      return null;
    }
  }

  Future<Map<String, dynamic>> fetchUserDataFromFirestore(User user) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore
          .instance
          .collection('users')
          .doc(user.uid)
          .get();

      return userDoc.exists ? userDoc.data() ?? {} : {};
    } catch (error) {
      print('Error fetching user data from Firestore: $error');
      return {};
    }
  }

  Future<void> saveUserDataInSharedPreferences(
      String userId, Map<String, dynamic> userData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', userId);
      await prefs.setString('username', userData['username']);
      await prefs.setString('name', userData['name']);
      await prefs.setString('email', userData['email']);
      // Add more fields as needed
      print('User data saved in SharedPreferences.');
    } catch (error) {
      print('Error saving user data to SharedPreferences: $error');
    }
  }

  Future<Map<String, String?>> getUserDataFromSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');
      String? username = prefs.getString('username');
      String? name = prefs.getString('name');
      String? email = prefs.getString('email');

      return {
        'userId': userId,
        'username': username,
        'name': name,
        'email': email,
      };
    } catch (error) {
      print('Error getting user data from SharedPreferences: $error');
      return {};
    }
  }

  Future<User?> checkUser() async {
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      await clearLoginStateAndUserData();
    } catch (error) {
      print('Sign Out Error: $error');
    }
  }

  Future<void> clearLoginStateAndUserData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // Get user ID from SharedPreferences
      String? userId = prefs.getString('userId');
      await prefs.remove('isLoggedIn');
      await prefs.remove('userId');
      await prefs.remove('username');
      await prefs.remove('email');
      // Remove additional user data (if any)
      // Example: prefs.remove('customField');
      // Remove userDoc from Firestore
      if (userId != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .delete();
      }
    } catch (error) {
      print('Error clearing login state and user data: $error');
    }
  }

  Future<String?> getUserIdFromSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('userId');
    } catch (error) {
      print('Error getting user ID from SharedPreferences: $error');
      return null;
    }
  }

  Future<String?> getUsernameFromSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString('username');
    } catch (error) {
      print('Error getting username from SharedPreferences: $error');
      return null;
    }
  }
}

// SharedPreferences prefs = await SharedPreferences.getInstance();
//       await prefs.setBool('isLoggedIn', true);