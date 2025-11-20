import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pulse_share/app/controllers/network_controller.dart';
import 'package:pulse_share/app/modules/received/controllers/received_controller.dart';

class HomeScreenController extends GetxController {
  static const platform = MethodChannel('com.syedbipul.pulse/native');
  static const eventChannel = EventChannel('com.syedbipul.pulse/events');

  var batteryLevel = 0.obs;
  var batteryTemp = 0.0.obs;
  var batteryHealth = ''.obs;
  var stepsSinceBoot = 0.obs;
  var currentActivity = 'Unknown'.obs;
  var ssid = 'Not connected'.obs;
  var rssi = ''.obs;
  var localIp = '0.0.0.0'.obs;
  var carrierName = 'No SIM'.obs;
  var signalDbm = ''.obs;
  var deviceModel = ''.obs;
  var androidVersion = ''.obs;
  var deviceName = ''.obs;

  StreamSubscription? _sub;

  @override
  void onInit() {
    super.onInit();
    _requestPermissions();
    _fetchStaticInfo();
    _sub = eventChannel.receiveBroadcastStream().listen(_handleEvent);
    Timer.periodic(const Duration(seconds: 5),
        (_) => platform.invokeMethod('refreshNetworkInfo'));
  }

  Future<void> _requestPermissions() async {
    await [
      Permission.phone,
      Permission.activityRecognition,
      Permission.location
    ].request();
  }

  Future<void> _fetchStaticInfo() async {
    try {
      final info = await platform.invokeMethod('getStaticDeviceInfo') as Map;
      deviceModel.value = "${info['brand']} ${info['model']}";
      androidVersion.value = info['androidVersion'] as String;
      deviceName.value = info['deviceName'] as String;
    } catch (e) {}
  }

  void _handleEvent(dynamic event) {
    if (event is Map) {
      if (event['type'] == 'peerFound') {
        Get.find<NetworkController>().addPeer(event);
      } else if (event['type'] == 'pulseReceived') {
        Get.find<ReceivedController>().addPulse(
            event['from'] as String? ?? 'Unknown', event['data'] as String);
      } else {
        batteryLevel.value = event['batteryLevel'] ?? batteryLevel.value;
        batteryTemp.value =
            (event['batteryTemp'] ?? batteryTemp.value).toDouble();
        batteryHealth.value = _healthText(event['batteryHealth']);
        stepsSinceBoot.value = event['steps'] ?? stepsSinceBoot.value;
        currentActivity.value = event['activity'] ?? currentActivity.value;
        ssid.value = event['ssid'] ?? ssid.value;
        rssi.value = event['rssi'] ?? rssi.value;
        localIp.value = event['localIp'] ?? localIp.value;
        carrierName.value = event['carrier'] ?? carrierName.value;
        signalDbm.value = event['signalDbm'] ?? signalDbm.value;
      }
    }
  }

  String _healthText(dynamic h) {
    switch (h) {
      case 2:
        return 'Good';
      case 3:
        return 'Overheat';
      case 6:
        return 'Cold';
      default:
        return 'Unknown';
    }
  }

  String getCurrentPulseJson() => jsonEncode({
        'deviceName': deviceName.value,
        'deviceModel': deviceModel.value,
        'androidVersion': androidVersion.value,
        'batteryLevel': batteryLevel.value,
        'batteryTemp': batteryTemp.value,
        'batteryHealth': batteryHealth.value,
        'steps': stepsSinceBoot.value,
        'activity': currentActivity.value,
        'ssid': ssid.value,
        'rssi': rssi.value,
        'localIp': localIp.value,
        'carrier': carrierName.value,
        'signalDbm': signalDbm.value,
        'timestamp': DateTime.now().toIso8601String(),
      });

  @override
  void onClose() {
    _sub?.cancel();
    super.onClose();
  }
}
