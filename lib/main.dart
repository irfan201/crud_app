import 'package:crud_app/app/routes/app_pages.dart';
import 'package:crud_app/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main()  {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Application",
      home: SplashScreen(),
      getPages: AppPages.routes,
    );
  }
}
