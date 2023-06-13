import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import '../models/RoomModel.dart';

class RoomProvider extends ChangeNotifier {
  List<RoomModel> rooms = [];

  RoomProvider() {
    initializeRooms();
  }
  // Returns an object that points to the rooms collection
  CollectionReference<RoomModel> getRoomsCollection() {
    return FirebaseFirestore.instance
        .collection(RoomModel.collectionName)
        // WIth converter converts the data from Firestore to room model objects and vice versa
        .withConverter(fromFirestore: (snapshot, _) => RoomModel.fromJson(snapshot.data()!), toFirestore: (room, _) => room.toJson());
  }

  // Creates a room with a unique id in Firestore
  Future<void> createRoominFireStore(RoomModel room) {
    return getRoomsCollection().doc(room.id).set(room);
  }

  // Get room list from firestore
  Future<List<RoomModel>> getRoomsFromFireStore() async {
    var querySnapshot = await getRoomsCollection().get();
    return querySnapshot.docs.map((room) => room.data()).toList();
  }


  // Add the rooms to a list variable
  initializeRooms() async {
    rooms = await getRoomsFromFireStore();
  }
}
