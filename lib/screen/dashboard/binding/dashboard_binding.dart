import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:indiatodayshamsher/screen/dashboard/controller/dashboard_controller.dart';

import 'package:get/get.dart';

class DashBoardBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
  }

}