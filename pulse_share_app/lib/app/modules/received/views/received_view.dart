import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/received_controller.dart';

class ReceivedView extends GetView<ReceivedController> {
  const ReceivedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Received Pulses')),
      body: Obx(() => controller.received.isEmpty
          ? const Center(child: Text('No received pulses yet'))
          : ListView.builder(
              itemCount: controller.received.length,
              itemBuilder: (context, index) {
                final pulse = controller.received[index];
                final data = jsonDecode(pulse.jsonData);
                return Card(
                  child: ListTile(
                    title: Text(pulse.deviceName),
                    subtitle: Text(
                      'Battery: ${data['batteryLevel']}% • Steps: ${data['steps']} • Time: ${pulse.timestamp.toLocal()}',
                    ),
                  ),
                );
              },
            )),
    );
  }
}