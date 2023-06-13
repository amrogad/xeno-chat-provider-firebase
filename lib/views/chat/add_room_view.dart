import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/cli_commands.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:xeno_chat/constants/Colors.dart';
import 'package:xeno_chat/services/xeno_form_validator.dart';
import 'package:xeno_chat/viewmodels/chat/add_room_viewmodel.dart';
import 'package:xeno_chat/widgets/xeno_button.dart';
import 'package:xeno_chat/widgets/xeno_scaffold.dart';
import 'package:xeno_chat/widgets/xeno_textfield.dart';
import '../../constants/Fonts.dart';
import '../../models/CategoryModel.dart';

class AddRoomView extends StatefulWidget {
  const AddRoomView({Key? key}) : super(key: key);
  static const id = 'add-room-view';

  @override
  State<AddRoomView> createState() => _AddRoomViewState();
}

class _AddRoomViewState extends State<AddRoomView> {
  final AddRoomViewModel addRoomViewModel = AddRoomViewModel();
  var categories = CategoryModel.getCategories();

  @override
  void dispose() {
    addRoomViewModel.roomTitleController.dispose();
    addRoomViewModel.roomDescController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    addRoomViewModel.selectedCategory = categories[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        addRoomViewModel;
      },
      child: XenoScaffold(
        body: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.sp)),
          child: Form(
            key: addRoomViewModel.addRoomFormKey,
            child: Column(
              children: [
                SizedBox(height: 150.h),
                AutoSizeText(
                  'Create New Room',
                  style: XenoFonts.bodyTextPrimary(context)?.copyWith(fontSize: 20.sp),
                ),
                SizedBox(width: 120.w, height: 120.h, child: Image.asset('assets/images/create_room.png')),
                XenoTextField(
                  title: "Room Name",
                  controller: addRoomViewModel.roomTitleController,
                  validator: XenoFormValidator.roomTitleValidator,
                ),
                Container(
                  padding: EdgeInsets.all(10.sp),
                  child: DropdownButton<CategoryModel>(
                      icon: const Icon(
                        Icons.arrow_drop_down,
                        color: XenoColors.primaryColor,
                      ),
                      underline: Container(
                        color: Colors.transparent,
                      ),
                      value: addRoomViewModel.selectedCategory,
                      items: categories
                          .map((category) => DropdownMenuItem<CategoryModel>(
                              value: category,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    category.image,
                                    height: 50.h,
                                    width: 60.w,
                                  ),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  AutoSizeText(category.name.capitalize(), style: XenoFonts.bodyTextPrimary(context)),
                                ],
                              )))
                          .toList(),
                      onChanged: (category) {
                        if (category == null) {
                          return;
                        } else {
                          setState(() {
                            addRoomViewModel.selectedCategory = category;
                          });
                        }
                      }),
                ),
                XenoTextField(
                  title: "Room Description",
                  controller: addRoomViewModel.roomDescController,
                  validator: XenoFormValidator.roomTitleValidator,
                ),
                SizedBox(height: 15.h),
                GestureDetector(
                  onTap: () {
                    addRoomViewModel.validateAndCreateRoom(context);
                  },
                  child: XenoButton(
                    text: 'Create Room',
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
