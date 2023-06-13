import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:xeno_chat/constants/Colors.dart';
import 'package:xeno_chat/widgets/xeno_room.dart';
import 'package:xeno_chat/widgets/xeno_scaffold.dart';
import '../../providers/room_provider.dart';
import '../chat/add_room_view.dart';
import '../auth/login_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  static const String id = 'home-view';

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    var roomProvider = Provider.of<RoomProvider>(context);

    return ChangeNotifierProvider(
      create: (BuildContext context) {
        roomProvider;
      },
      child: XenoScaffold(
        appBarTitle: 'Chat Rooms',
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: GestureDetector(
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                if (context.mounted) {
                  Navigator.pushReplacementNamed(context, LoginView.id);
                }
              },
              child: const Icon(Icons.settings),
            ),
          ),
        ],
        floatingActionButton: FloatingActionButton(
          backgroundColor: XenoColors.primaryColor,
          onPressed: () {
            Navigator.pushNamed(context, AddRoomView.id);
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp),
          child: Column(
            children: [
              SizedBox(
                height: 220.h,
              ),
              Expanded(
                child: Consumer<RoomProvider>(
                  builder: (context, provider, child) {
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 20.h,
                          crossAxisSpacing: 10.w,
                        ),
                        itemCount: provider.rooms.length,
                        itemBuilder: (context, index) {
                          return XenoRoom(room: provider.rooms[index]);
                        });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
