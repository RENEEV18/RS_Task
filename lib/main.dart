import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rs_task/controller/home_controller/home_controller.dart';
import 'package:rs_task/utils/colors/colors.dart';
import 'package:rs_task/view/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeController(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: AppColors.kOrange,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
