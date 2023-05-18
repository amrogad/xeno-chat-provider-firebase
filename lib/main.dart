import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xeno_chat/views/register_view.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, Widget? child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Xeno Chat',
          theme: ThemeData(
            useMaterial3: true,
          ),
          initialRoute: RegisterView.id,
          routes: {
            RegisterView.id: (c) => const RegisterView(),
          },
        );
      },
    );
  }
}
