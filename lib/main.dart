import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:rs_task/controller/home_controller/home_controller.dart';
import 'package:rs_task/model/hive_data_model/local_data_model.dart';
import 'package:rs_task/utils/colors/colors.dart';
import 'package:rs_task/view/home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(GetLocalDataModelAdapter().typeId)) {
    Hive.registerAdapter(GetLocalDataModelAdapter());
  }
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
