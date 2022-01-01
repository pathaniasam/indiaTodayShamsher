import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:indiatodayshamsher/routes/app_pages.dart';
import 'package:indiatodayshamsher/routes/app_routes.dart';
import 'package:indiatodayshamsher/utils/app_colors.dart';
import 'package:indiatodayshamsher/utils/const_strings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(

      debugShowCheckedModeBanner: false,
      title: Strings.appName,
      initialRoute:AppRoutes.Home,
      theme: ThemeData(
        primaryColor: AppColors.green,
        accentColor: AppColors.green,
      ),
      getPages: AppPages.list,
    );
  }
}

