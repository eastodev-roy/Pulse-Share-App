import 'package:hive/hive.dart';
// part 'received_pulse.g.dart';

@HiveType(typeId: 0)
class ReceivedPulse extends HiveObject {
  @HiveField(0) final String deviceName;
  @HiveField(1) final String jsonData;
  @HiveField(2) final DateTime timestamp;

  ReceivedPulse({
    required this.deviceName,
    required this.jsonData,
    required this.timestamp,
  });
}