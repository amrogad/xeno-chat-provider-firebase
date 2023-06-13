import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:xeno_chat/models/MessageModel.dart';
import 'package:xeno_chat/models/RoomModel.dart';
import 'package:xeno_chat/models/UserModel.dart';
import 'package:xeno_chat/providers/room_provider.dart';
import 'package:xeno_chat/widgets/xeno_snackbar.dart';

class ChatViewModel extends ChangeNotifier {
  RoomProvider roomProvider = RoomProvider();
  String messageContent = '';
  TextEditingController messageController = TextEditingController();
  late RoomModel room;
  late UserModel currentUser;

  // Get the document in the RoomsCollection with the given roomId
  // Return the collection of MessageModel objects from the roomDocument
  CollectionReference<MessageModel> getMessagesCollection(String roomId) {
    return roomProvider
        .getRoomsCollection()
        .doc(roomId)
        .collection(MessageModel.collectionName)
        .withConverter<MessageModel>(fromFirestore: (snapshot, _) => MessageModel.fromJson(snapshot.data()!), toFirestore: (message, _) => message.toJson());
  }

  Future<void> addMessageToFireStore(MessageModel message, String roomId) async {
    var roomMessage = getMessagesCollection(message.roomId);
    var docRef = roomMessage.doc();
    message.id = docRef.id;
    return docRef.set(message);
  }

  // Send button functionality, take the message from the textfield and add it to the chat box
  Future<void> addMessageToChatScreen(BuildContext context, String roomId) async {
    MessageModel message = MessageModel(
        roomId: room.id,
        content: messageController.text,
        dateTime: DateTime.now().microsecondsSinceEpoch,
        senderId: currentUser.id,
        senderName: currentUser.firstName);
    try {
      await addMessageToFireStore(message, roomId);
      messageController.clear();
    } catch (error) {
      log('CHAT SEND ERROR: $error');
      XenoSnackBars.showXenoErrorSnackBar(context, message: 'An error has occurred, please try again later.');
    }
  }

  // Stream of message snapshots, this will be the messages displayed in the chat and order by date
  Stream<QuerySnapshot<MessageModel>> getMessageStreams(String roomId) {
    return getMessagesCollection(roomId).orderBy('dateTime').snapshots();
  }
}
