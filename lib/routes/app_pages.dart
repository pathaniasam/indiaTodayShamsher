import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:indiatodayshamsher/routes/app_routes.dart';
import 'package:indiatodayshamsher/screen/dashboard/binding/dashboard_binding.dart';
import 'package:indiatodayshamsher/screen/dashboard/controller/dashboard_controller.dart';
import 'package:indiatodayshamsher/screen/dashboard/view/dashboard_view.dart';
import 'package:indiatodayshamsher/screen/home/binding/home_binding.dart';
import 'package:indiatodayshamsher/screen/home/view/home_view.dart';

class AppPages {
  static var list = [


    GetPage(
      name: AppRoutes.Home,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),



    GetPage(
      name: AppRoutes.Home,
      page: () => DashBoardView(),
      binding: DashBoardBinding(),
    ),


  ];
}
