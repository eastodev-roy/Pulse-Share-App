import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse_share/app/modules/HomeScreen/controllers/home_screen_controller.dart';
import '../../../controllers/network_controller.dart';

class HomeScreenView extends GetView<HomeScreenController> {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    final net = Get.find<NetworkController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Pulse Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Get.toNamed('/received'),
          ),
        ],
      ),
      body: Obx(() => RefreshIndicator(
            onRefresh: () => Future.delayed(const Duration(seconds: 1)),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _section('Device Info', [
                  'Name: ${controller.deviceName.value}',
                  'Model: ${controller.deviceModel.value}',
                  'Android: ${controller.androidVersion.value}',
                ]),
                _section('Battery', [
                  'Level: ${controller.batteryLevel.value}%',
                  'Temp: ${controller.batteryTemp.value}°C',
                  'Health: ${controller.batteryHealth.value}',
                ]),
                _section('Motion', [
                  'Steps since boot: ${controller.stepsSinceBoot.value}',
                  'Activity: ${controller.currentActivity.value}',
                ]),
                _section('Wi-Fi', [
                  'SSID: ${controller.ssid.value}',
                  'RSSI: ${controller.rssi.value} dBm',
                  'Local IP: ${controller.localIp.value}',
                ]),
                _section('Cellular', [
                  'Carrier: ${controller.carrierName.value}',
                  'Signal: ${controller.signalDbm.value} dBm',
                ]),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    net.startDiscovery();
                  },
                  child: const Text('Share My Pulse'),
                ),
                if (net.isDiscovering.value)
                  const Center(child: CircularProgressIndicator()),
                ...net.peers.map((peer) => ListTile(
                      title: Text(peer.name),
                      subtitle: Text(peer.ip),
                      trailing: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: () => net.sendTo(peer),
                      ),
                    )),
              ],
            ),
          )),
    );
  }

  Widget _section(String title, List<String> items) => Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18)),
              ...items.map((i) => Text(i)).toList(),
            ],
          ),
        ),
      );
}
