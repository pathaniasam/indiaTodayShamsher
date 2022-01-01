import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import 'package:get/get.dart';
import 'package:indiatodayshamsher/screen/talktoastro/controller/talk_astro_controller.dart';

class AstroBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<AstroController>(() => AstroController());
  }

}