import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pulse_share/app/modules/HomeScreen/controllers/home_screen_controller.dart';
// import 'package:pulse_share/app/modules/HomeScreen/controllers/home_screen_controller.dart';

class Peer {
  final String name;
  final String ip;
  Peer(this.name, this.ip);
}

class NetworkController extends GetxController {
  static final platform = MethodChannel('com.syedbipul.pulse/native');

  var peers = <Peer>[].obs;
  var isDiscovering = false.obs;

  @override
  void onInit() {
    super.onInit();
    platform.invokeMethod('registerNsdService');
  }

  Future<void> startDiscovery() async {
    isDiscovering.value = true;
    peers.clear();
    await platform.invokeMethod('startDiscovery');
  }

  void addPeer(Map data) {
    final peer = Peer(data['name'] as String, data['ip'] as String);
    if (!peers.any((p) => p.ip == peer.ip)) {
      peers.add(peer);
    }
  }

  Future<void> sendTo(Peer peer) async {
    final json = Get.find<HomeScreenController>().getCurrentPulseJson();
    final success = await platform.invokeMethod(
        'sendTcpData', {'ip': peer.ip, 'port': 48484, 'data': json});
    Get.snackbar('Share', success ? 'Sent to ${peer.name}!' : 'Failed to send');
  }

  Future<void> stopDiscovery() async {
    await platform.invokeMethod('stopDiscovery');
    isDiscovering.value = false;
  }

  @override
  void onClose() {
    stopDiscovery();
    super.onClose();
  }
}
