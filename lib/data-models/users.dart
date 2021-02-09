import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class User {
  String name;
  String title;
  String uid;
  String email;
  String phoneNumber;
  String profilePictureUrl;
  bool isAdmin;
  bool isActive;

  User({
    this.name = "",
    this.title = "Job Title",
    this.uid = "",
    this.email = "",
    this.phoneNumber = "",
    this.profilePictureUrl = "",
    this.isAdmin = false,
    this.isActive = true,
  });

  @override
  String toString() {
    return "Name: " +
        name +
        "\nEmail: " +
        email +
        "\nPhone Number: " +
        phoneNumber +
        "\nUID: " +
        uid;
  }
}

User getUserFromFirebaseUser(FirebaseUser firebUser) {
  return firebUser != null
      ? User(
          email: firebUser.email,
          name: firebUser.displayName,
          uid: firebUser.uid,
          phoneNumber: firebUser.phoneNumber,
          profilePictureUrl: firebUser.photoUrl)
      : null;
}

User getUserFromDecoment(DocumentSnapshot doc) {
  return User(
      name: doc.data['name'],
      uid: doc.data['uid'],
      email: doc.data['email'],
      phoneNumber: doc.data['phoneNumber'],
      profilePictureUrl: doc.data['profilePictureUrl'],
      isAdmin: doc.data['isAdmin'],
      isActive: doc.data['isActive'],
      title: doc.data['title']);
}
