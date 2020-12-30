import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import '../models/user.dart';

class CredentialsProvider with ChangeNotifier {
  String firstName;
  String lastName;
  String parish;
  String uid;
  String photoLink;
  String email;
  FirebaseAuth _auth;
  CredentialsProvider(this._auth);

  Future<User> getUserFromFirebase(_auth) async {
    FirebaseUser user = await _auth.currentUser();
    uid = user.uid;
    Firestore.instance
        .collection('users')
        .document(uid)
        .snapshots()
        .listen((user) {
      // print(data.data['image_url']);
      firstName = user.data['firstName'];
      lastName = user.data['lastName'];
      parish = user.data['parish'];
      photoLink = user.data['image_url'];
      email = user.data['email'];
      User firebaseUser = new User(
          email: email,
          firstName: firstName,
          lastName: lastName,
          photoLink: photoLink,
          uid: uid,
          parish: parish);
      print(firebaseUser.firstName);
      return firebaseUser;
    });
    notifyListeners();

    return null;
  }
}
