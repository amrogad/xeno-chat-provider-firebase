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

  // Returns an object that points to the users collection
  CollectionReference<UserModel> getUsersCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.collectionName)
        // WIth converter converts the data from firestore to UserModel objects and vice versa
        .withConverter(fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!), toFirestore: (user, _) => user.toJson());
  }

  // Reads a user from Firebase Firestore and returns it as a UserModel object.
  Future<UserModel?> readUserDataInFireStore(String userId) async {
    var userSnapShot = await getUsersCollection().doc(userId).get();
    return userSnapShot.data();
  }

  // Check if auth user is not null then assign it to user variable
  Future<void> initializeUser() async {
    if (firebaseUser != null) {
      user = await readUserDataInFireStore(firebaseUser?.uid ?? '');
    }
  }

  // Creates a user with a unique id in Firestore
  Future<void> createUserinFireStore(UserModel user) {
    return getUsersCollection().doc(user.id).set(user);
  }
}
