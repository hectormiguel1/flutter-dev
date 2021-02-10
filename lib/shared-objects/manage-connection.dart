import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pem_app_flutter/data-models/users.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final Firestore _dbinstance = Firestore.instance;
User _currentUser;

User currentUser() => _currentUser;

/// Attempts to login user with [email] and [password]
/// Returns [User] on success [null] on failure.
Future<User> loginUserWithPassword(
    {@required String password, @required String email}) async {
  try {
    AuthResult result =
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    String userUID = result.user.uid;
    DocumentSnapshot user =
    await _dbinstance.collection("Users").document(userUID).get();

    _currentUser = getUserFromDecoment(user);

    return _currentUser;
  } catch (exception) {
    return null;
  }
}

void signOut() {
  _auth.signOut();
}

/**
 * Returns the current instance to the [database]
 */
Firestore getFirestoreDB() => _dbinstance;

/**
 * Register [user] to firebase with [password].
 * Adds [user] to Users firestore detabase.
 */
Future<bool> registerUser(User user, String password) async {
  try {
    AuthResult firebase_answer = await _auth.createUserWithEmailAndPassword(
        email: user.email, password: password);
    String userUID = firebase_answer.user.uid.toString();
    await _dbinstance.collection('Users').document(userUID).setData({
      'email': user.email,
      'isAdmin': user.isAdmin,
      'name': user.name,
      'phoneNumber': user.phoneNumber,
      'profilePictureUrl': user.profilePictureUrl,
      'uid': userUID,
      'isActive': user.isActive,
      'title': user.title,
    });
    return true;
  } on AuthException catch (err) {
    print(err.code);
    return false;
  } catch (err) {
    print(err);
    return false;
  }
}

User reloadUser() {
  _dbinstance.collection('Users').document(_currentUser.uid).get().then((doc) {
    _currentUser = getUserFromDecoment(doc);
  });

  return _currentUser;
}

void updateUser(User user) {
  _dbinstance.collection('Users').document(user.uid).setData(({
        'email': user.email,
        'isAdmin': user.isAdmin,
        'name': user.name,
        'phoneNumber': user.phoneNumber,
        'profilePictureUrl': user.profilePictureUrl,
        'uid': user.uid,
        'isActive': user.isActive,
        'title': user.title,
      }));
}
