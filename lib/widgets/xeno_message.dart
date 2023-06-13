import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:xeno_chat/constants/Colors.dart';
import 'package:xeno_chat/constants/Fonts.dart';
import '../models/MessageModel.dart';
import '../providers/user_provider.dart';

class XenoMessage extends StatelessWidget {
  final MessageModel message;
  const XenoMessage(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return userProvider.user?.id == message.senderId
        ? Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: XenoSentMessage(message),
          )
        : Padding(
            padding: EdgeInsets.all(8.0.sp),
            child: XenoRecievedMessage(message),
          );
  }
}

class XenoSentMessage extends StatelessWidget {
  final MessageModel message;
  const XenoSentMessage(this.message, {super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
              color: XenoColors.primaryColor,
              borderRadius: BorderRadius.circular(
                12,
              )),
          child: AutoSizeText(
            message.content,
            style: XenoFonts.bodyTextWhite(context),
          ),
        ),
        AutoSizeText(
          DateTime.fromMicrosecondsSinceEpoch(message.dateTime).toString().substring(0, 19),
          style: XenoFonts.bodyTextPrimary(context)?.copyWith(fontSize: 1),
        ),
      ],
    );
  }
}

class XenoRecievedMessage extends StatelessWidget {
  final MessageModel message;
  const XenoRecievedMessage(this.message, {super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(10.sp),
          decoration: BoxDecoration(
              color: XenoColors.secondaryColor,
              borderRadius: BorderRadius.circular(
                12,
              )),
          child: AutoSizeText(
            message.content,
            style: XenoFonts.bodyTextWhite(context),
          ),
        ),
        AutoSizeText(
          DateTime.fromMicrosecondsSinceEpoch(message.dateTime).toString().substring(0, 19),
          style: XenoFonts.bodyTextPrimary(context)?.copyWith(fontSize: 1),
        ),
      ],
    );
  }
}
