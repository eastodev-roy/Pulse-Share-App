import 'package:get/get.dart';

import '../modules/HomeScreen/bindings/home_screen_binding.dart';
import '../modules/HomeScreen/views/home_screen_view.dart';
import '../modules/received/bindings/received_binding.dart';
import '../modules/received/views/received_view.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();
  static final INITIAL = Routes.HOME_SCREEN;
  static final routes = [
    GetPage(
      name: _Paths.HOME_SCREEN,
      page: () => HomeScreenView(),
      binding: HomeScreenBinding(),
    ),
    GetPage(
      name: _Paths.RECEIVED,
      page: () => const ReceivedView(),
      binding: ReceivedBinding(),
    ),
  ];
}
