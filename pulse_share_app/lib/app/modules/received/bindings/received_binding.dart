import 'package:get/get.dart';

import '../controllers/received_controller.dart';

class ReceivedBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReceivedController>(
      () => ReceivedController(),
    );
  }
}
