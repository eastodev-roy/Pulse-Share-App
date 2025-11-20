# Pulse Share - Flutter Technical Task

This is a Flutter app built as a technical task for SparkTech Agency. The app collects real-time device and health data and allows instant sharing with nearby devices on the same Wi-Fi network.

## Features

- **Live Dashboard**
  - Displays real-time device and health data on app launch
  - Battery level, temperature, and health
  - Step count since device boot
  - Detected activity (Walking, Still, etc.)
  - Wi-Fi SSID, signal strength (RSSI), local IP
  - Carrier name, cellular signal strength (dBm), SIM state
  - Device model, Android version, device name

- **Share My Pulse**
  - Discover peers automatically on the same Wi-Fi
  - Display peer list
  - Send real-time data to selected peers

- **Received Data Screen**
  - Displays a list of recently received device snapshots
  - Persisted locally using Hive across app restarts

## Technical Details

- **Flutter Version:** 3.x+  
- **Android Minimum SDK:** 21  
- **State Management:** GetX (Rx observables for live updates)  
- **Local Storage:** Hive  
- **Networking:** NSD (Network Service Discovery) + TCP Sockets  
- **Platform Channels:** MethodChannel and EventChannel used to access native Android sensors and networking

## Installation & Setup

1. Clone the repository:

```bash
git clone https://github.com/<eastodev-roy>/pulse_share_flutter_task.git
cd pulse_share_flutter_task
