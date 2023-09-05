import 'package:bot_toast/bot_toast.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tpm/view/auth/login.dart';
import 'package:get/get.dart';

import 'Routes/app_pages.dart';
import 'network/enviroment.dart';

List<CameraDescription>? cameras;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await GetStorage.init();
  // const String environment = String.fromEnvironment(
  //   'ENVIRONMENT',
  //   defaultValue: Environment.dev,
  // );

  Enviroment().initConfig('ENVIRONMENT');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TPM',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      getPages: AppPages.routes,
      initialRoute: AppPages.initial,
    );
  }
}