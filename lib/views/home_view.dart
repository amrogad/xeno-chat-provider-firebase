import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xeno_chat/constants/Colors.dart';
import 'package:xeno_chat/viewmodels/home_viewmodel.dart';
import 'package:xeno_chat/widgets/xeno_scaffold.dart';
import 'add_room_view.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  static const String id = 'home-view';
  HomeViewModel homeViewModel = HomeViewModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        homeViewModel;
      },
      child: XenoScaffold(
        appBarTitle: 'Home',
        floatingActionButton: FloatingActionButton(
          backgroundColor: XenoColors.primaryColor,
          onPressed: () {
            Navigator.pushNamed(context, AddRoomView.id);
          },
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body: Container(),
      ),
    );
  }
}
