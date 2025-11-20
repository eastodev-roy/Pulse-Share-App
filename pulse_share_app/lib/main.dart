import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pulse_share/app/data/models/received_pulse_adapter.dart';
import 'package:pulse_share/app/data/models/recived_pule.dart';
import 'package:pulse_share/app/modules/HomeScreen/bindings/home_screen_binding.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ReceivedPulseAdapter());
  await Hive.openBox<ReceivedPulse>('received_pulses');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Pulse Share",
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      initialRoute: Routes.HOME_SCREEN,
      getPages: AppPages.routes,
      initialBinding: HomeScreenBinding(),
    );
  }
}
