import 'package:hive/hive.dart';
import 'recived_pule.dart';

class ReceivedPulseAdapter extends TypeAdapter<ReceivedPulse> {
  @override
  final int typeId = 0;

  @override
  ReceivedPulse read(BinaryReader reader) {
    return ReceivedPulse(
      deviceName: reader.readString(),
      jsonData: reader.readString(),
      timestamp: DateTime.parse(reader.readString()),
    );
  }

  @override
  void write(BinaryWriter writer, ReceivedPulse obj) {
    writer.writeString(obj.deviceName);
    writer.writeString(obj.jsonData);
    writer.writeString(obj.timestamp.toIso8601String());
  }
}
