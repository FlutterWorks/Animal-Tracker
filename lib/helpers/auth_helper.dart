import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/profile.dart';

class AuthHelper {
  static Future<UserData> fetchData() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user;
    String firstName;
    String lastName;
    String parish;
    String uid;
    String photoLink;

    user = await _auth.currentUser();
    uid = user.uid;
    Firestore.instance
        .collection('users')
        .document(uid)
        .snapshots()
        .listen((user) {
      firstName = user.data['firstName'];
      lastName = user.data['lastName'];
      parish = user.data['parish'];
      photoLink = user.data['image_url'];
    });

    return UserData(
        uid: uid,
        firstName: firstName,
        lastName: lastName,
        parish: parish,
        photoLink: photoLink);
  }
}