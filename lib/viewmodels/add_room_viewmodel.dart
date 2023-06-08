import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/CategoryModel.dart';
import '../models/Room.dart';
import '../services/services.dart';
import '../widgets/xeno_snackbar.dart';

class AddRoomViewModel extends ChangeNotifier {
  final GlobalKey<FormState> addRoomFormKey = GlobalKey<FormState>();
  final TextEditingController roomTitleController = TextEditingController();
  final TextEditingController roomDescController = TextEditingController();
  late CategoryModel selectedCategory;

  // Create a new room
  Future<void> validateAndCreateRoom(BuildContext context) async {
    try {
      Services.rotatedSpinner(context);
      if (addRoomFormKey.currentState!.validate()) {
        final room = Room(
          categoryId: selectedCategory.id,
          title: roomTitleController.text.trim(),
          desc: roomDescController.text.trim(),
        );
        createRoominFireStore(room);
        if (context.mounted) {
          XenoSnackBars.showXenoSuccessSnackBar(context, message: 'Your room has been created!');
          Navigator.pop(context);
        }
      } else {
        Navigator.pop(context);
        return;
      }
    } catch (error) {
      XenoSnackBars.showXenoErrorSnackBar(context, message: 'An error has occurred please try again later!');
      Navigator.pop(context);
    }
  }

  // Returns an object that points to the rooms collection of the room model
  CollectionReference<Room> getRoomCollection() {
    return FirebaseFirestore.instance
        .collection(Room.collectionName)
        // WIth converter converts the data from Firestore to room model objects and vice versa
        .withConverter(fromFirestore: (snapshot, _) => Room.fromJson(snapshot.data()!), toFirestore: (room, _) => room.toJson());
  }

  // Creates a room with a unique id in Firestore
  Future<void> createRoominFireStore(Room room) {
    return getRoomCollection().doc(room.id).set(room);
  }
}
