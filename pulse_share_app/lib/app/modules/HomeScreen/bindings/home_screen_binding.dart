import 'package:get/get.dart';
import 'package:pulse_share/app/controllers/network_controller.dart';

import '../controllers/home_screen_controller.dart';

class HomeScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeScreenController>(
      () => HomeScreenController(),
    );
    Get.lazyPut<NetworkController>(() => NetworkController());
  }
}
