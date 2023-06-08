import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../models/UserModel.dart';

class UserProvider extends ChangeNotifier {
  UserModel? user;
  User? firebaseUser;
  UserProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    initializeUser();
  }

  // Returns an object that points to the users collection of the user model
   CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection('users')
        // WIth converter converts the data from firestore to UserModel objects and vice versa
        .withConverter(fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!), toFirestore: (user, _) => user.toJson());
  }

  // Reads a user from Firebase Firestore and returns it as a UserModel object.
   Future<UserModel?> readUserDataInFireStore(String userId) async {
    var snapshot = await getUserCollection().doc(userId).get();
    return snapshot.data();
  }

  // Check if auth user is not null then assign it to user variable
  initializeUser() async {
    if (firebaseUser != null) {
      user = await readUserDataInFireStore(firebaseUser?.uid ?? '');
    }
  }

  // Creates a user with a unique id in Firestore
   Future<void> createUserinFireStore(UserModel user) {
    return getUserCollection().doc(user.id).set(user);
  }
}
