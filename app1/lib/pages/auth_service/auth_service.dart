import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      final User? user = authResult.user;

      if (user != null) {
        // User signed in successfully, now store user data in Firestore
        await storeUserDataInFirestore(user);

        // Save login state in shared preferences
        saveLoginState();

        return user;
      } else {
        return null;
      }
    } catch (error) {
      print('Google Sign-In Error: $error');
      return null;
    }
  }

  Future<void> storeUserDataInFirestore(User user) async {
    try {
      // Create a reference to the Firestore collection where user data will be stored
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');

      // Check if the user already exists in Firestore
      DocumentSnapshot userData = await users.doc(user.uid).get();
      if (!userData.exists) {
        // If the user doesn't exist, create a new document in the 'users' collection
        await users.doc(user.uid).set({
          'displayName': user.displayName,
          'email': user.email,
          'photoURL': user.photoURL,
          // Add any additional user data fields you want to store
        });
      }
    } catch (error) {
      print('Error storing user data in Firestore: $error');
    }
  }

  Future<void> saveLoginState() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
    } catch (error) {
      print('Error saving login state: $error');
    }
  }

  Future<User?> checkUser() async {
    return _auth.currentUser;
  }

  Future<void> signOut() async {
    try {
      // Sign out from Firebase and Google
      await _auth.signOut();
      await _googleSignIn.signOut();

      // Clear login state from shared preferences
      clearLoginState();
    } catch (error) {
      print('Sign Out Error: $error');
    }
  }

  Future<void> clearLoginState() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn');
    } catch (error) {
      print('Error clearing login state: $error');
    }
  }
}
