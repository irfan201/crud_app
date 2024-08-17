import 'package:crud_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Get.offAllNamed(Routes.REGISTER);
    });

    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://hrisapps.mahasejahtera.com/assets/img/logo-maha-akbar.png', width: 250,height: 250,),
            SizedBox(height: 20,),
            Text('Welcome to Crud App', style: TextStyle(fontSize: 24)),
          ],
        ),
      ),
    );
  }
}
