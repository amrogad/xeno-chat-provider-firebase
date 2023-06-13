import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:xeno_chat/constants/Colors.dart';
import 'package:xeno_chat/constants/Fonts.dart';
import 'package:xeno_chat/providers/user_provider.dart';
import 'package:xeno_chat/services/services.dart';
import 'package:xeno_chat/services/xeno_form_validator.dart';
import 'package:xeno_chat/viewmodels/chat/chat_viewmodel.dart';
import 'package:xeno_chat/widgets/xeno_message.dart';
import 'package:xeno_chat/widgets/xeno_scaffold.dart';
import 'package:xeno_chat/widgets/xeno_textfield.dart';
import '../../models/MessageModel.dart';
import '../../models/RoomModel.dart';
import '../../widgets/xeno_snackbar.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);
  static const id = 'chat-room-view';

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  ChatViewModel chatViewModel = ChatViewModel();

  @override
  void dispose() {
    chatViewModel.messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var room = ModalRoute.of(context)?.settings.arguments as RoomModel;
    var userProvider = Provider.of<UserProvider>(context);
    chatViewModel.currentUser = userProvider.user!;
    chatViewModel.room = room;
    return XenoScaffold(
      appBarTitle: room.title,
      body: ChangeNotifierProvider(
        create: (BuildContext context) {
          chatViewModel;
        },
        child: Container(
          margin: EdgeInsets.all(15.sp),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot<MessageModel>>(
                    stream: chatViewModel.getMessageStreams(room.id),
                    builder: (c, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator(
                          color: XenoColors.primaryColor,
                        );
                      }
                      if (snapshot.hasError) {
                        return Text(
                          snapshot.error.toString(),
                          style: XenoFonts.bodyTextPrimary(context),
                        );
                      }
                      var messages = snapshot.data?.docs.map((mess) => mess.data()).toList();
                      return ListView.builder(
                          itemCount: messages?.length ?? 0,
                          itemBuilder: (c, index) {
                            return XenoMessage(messages![index]);
                          });
                    },
                  ),
                ),

              Row(
                children: [
                  Expanded(
                      child: XenoTextField(
                          controller: chatViewModel.messageController,
                          validator: XenoFormValidator.messageValidator,
                          hintText: 'Write a message...',
                          hintStyle: XenoFonts.bodyTextPrimary(context),
                          onChanged: (text) {
                            chatViewModel.messageController.text = text;
                          })),
                  SizedBox(width: 5.w),
                  GestureDetector(
                    onTap: () {
                      chatViewModel.addMessageToChatScreen(context, chatViewModel.messageController.text);
                    },
                    child: const Icon(
                      Icons.send,
                      color: XenoColors.primaryColor,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
