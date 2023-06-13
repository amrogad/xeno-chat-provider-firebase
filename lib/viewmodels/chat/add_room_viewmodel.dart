import 'package:flutter/material.dart';
import '../../models/CategoryModel.dart';
import '../../models/RoomModel.dart';
import '../../providers/room_provider.dart';
import '../../services/services.dart';
import '../../widgets/xeno_snackbar.dart';

class AddRoomViewModel extends ChangeNotifier {
  final GlobalKey<FormState> addRoomFormKey = GlobalKey<FormState>();
  final TextEditingController roomTitleController = TextEditingController();
  final TextEditingController roomDescController = TextEditingController();
  late CategoryModel selectedCategory;
  final RoomProvider roomProvider = RoomProvider();

  // Create a new room
  Future<void> validateAndCreateRoom(BuildContext context) async {
    try {
      Services.rotatedSpinner(context);
      if (addRoomFormKey.currentState!.validate()) {
        var roomCollectionDocRef = roomProvider.getRoomsCollection().doc();
        final room = RoomModel(
          id: roomCollectionDocRef.id,
          categoryId: selectedCategory.id,
          title: roomTitleController.text.trim(),
          desc: roomDescController.text.trim(),
        );
        roomProvider.createRoominFireStore(room);
        if (context.mounted) {
          XenoSnackBars.showXenoSuccessSnackBar(context, message: 'Your room has been created successfully!');
          roomTitleController.clear();
          roomDescController.clear();
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


}
