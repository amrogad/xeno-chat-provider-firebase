import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xeno_chat/constants/Colors.dart';
import 'package:xeno_chat/views/login_view.dart';
import 'package:xeno_chat/views/register_view.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: XenoColors.primaryColor),
            useMaterial3: true,
          ),
          initialRoute: LoginView.id,
          routes: {
            RegisterView.id: (c) => const RegisterView(),
            LoginView.id: (c) => const LoginView(),
          },
            // App font sizes can only be 3x bigger to reduce chances of overflow
            builder: (context, child) {
              final mediaQueryData = MediaQuery.of(context);
              final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.3);
              return MediaQuery(data: mediaQueryData.copyWith(textScaleFactor: scale), child: child!);
            }
        );
      },
    );
  }
}
