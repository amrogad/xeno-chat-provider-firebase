import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xeno_chat/constants/Colors.dart';
import 'package:xeno_chat/constants/Fonts.dart';
import 'package:xeno_chat/models/RoomModel.dart';
import '../views/chat/chat_view.dart';

class XenoRoom extends StatelessWidget {
  const XenoRoom({Key? key, required this.room}) : super(key: key);

  final RoomModel room;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, ChatView.id, arguments: room);
      },
      child: Container(
        padding: EdgeInsets.all(10.sp),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: XenoColors.primaryColor,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              blurRadius: 5,
              spreadRadius: 2,
              offset: const Offset(0, 3),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                'assets/images/rooms/${room.categoryId}.png',
              ),
            ),
            AutoSizeText(
              room.title,
              style: XenoFonts.bodyTextPrimary(context),
            )
          ],
        ),
      ),
    );
  }
}
