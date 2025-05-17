import 'package:dapoeutsrahapp/config/routes/app_pages.dart';
import 'package:dapoeutsrahapp/config/routes/app_routes.dart';
import 'package:dapoeutsrahapp/controller/shift/shift_controller.dart';
import 'package:dapoeutsrahapp/pages/shift/main_shift_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.getStarted,
      getPages: AppPages.pages,
    );
  }
}
