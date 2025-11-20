import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:pulse_share/app/data/models/recived_pule.dart';

class ReceivedController extends GetxController {
  final box = Hive.box<ReceivedPulse>('received_pulses');
  var received = <ReceivedPulse>[].obs;

  @override
  void onInit() {
    super.onInit();
    received.assignAll(box.values.toList()..sort((a, b) => b.timestamp.compareTo(a.timestamp)));
  }

  void addPulse(String deviceName, String jsonData) {
    final pulse = ReceivedPulse(
      deviceName: deviceName,
      jsonData: jsonData,
      timestamp: DateTime.now(),
    );
    box.add(pulse);
    received.insert(0, pulse);
    Get.snackbar('New Pulse', 'Received from $deviceName');
  }
}