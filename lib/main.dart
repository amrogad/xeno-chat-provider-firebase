import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:xeno_chat/constants/Colors.dart';
import 'package:xeno_chat/providers/room_provider.dart';
import 'package:xeno_chat/providers/user_provider.dart';
import 'package:xeno_chat/views/auth/register_view.dart';
import 'package:xeno_chat/views/chat/add_room_view.dart';
import 'package:xeno_chat/views/chat/chat_view.dart';
import 'package:xeno_chat/views/home/home_view.dart';
import 'package:xeno_chat/views/auth/login_view.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider<UserProvider>(create: (c) => UserProvider()), ChangeNotifierProvider<RoomProvider>(create: (c) => RoomProvider())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var userProvider = Provider.of<UserProvider>(context);
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: XenoColors.primaryColor),
            useMaterial3: true,
          ),
          initialRoute: userProvider.firebaseUser == null ? LoginView.id : HomeView.id,
          routes: {
            RegisterView.id: (c) => const RegisterView(),
            LoginView.id: (c) => const LoginView(),
            HomeView.id: (c) => const HomeView(),
            AddRoomView.id: (c) => const AddRoomView(),
            ChatView.id: (c) => const ChatView()
          },
        );
      },
    );
  }
}
