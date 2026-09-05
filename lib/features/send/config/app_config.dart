class AppConfig {
  static const String appName = 'Miros';
  static const String appVersion = '1.0.0';
  
  // Network Ports
  static const int defaultUdpPort = 53317;
  static const int defaultTcpPort = 53318;
  
  // Discovery
  static const String mDnsServiceName = '_miros._tcp.local';
  static const Duration discoveryInterval = Duration(seconds: 2);
  
  // Transfer
  static const int defaultChunkSize = 512 * 1024; // 512 KB
  static const int maxSimultaneousTransfers = 3;
  
  // Storage
  static const String hiveBoxSettings = 'settings';
  static const String hiveBoxHistory = 'history';
}



