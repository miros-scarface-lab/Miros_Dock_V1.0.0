import 'package:isar/isar.dart';

part 'server_config.g.dart';

@collection
class ServerConfig {
  Id id = Isar.autoIncrement;

  int port = 8080;
  
  String? selectedInterface;

  bool authenticationEnabled = false;
  String adminUsername = 'miros';
  String adminPasswordHash = ''; // Set to hashed 'miros' in DatabaseService

  bool uploadEnabled = true;
  bool downloadEnabled = true;
  bool deleteEnabled = true;
  bool renameEnabled = true;

  int maxClients = 10;
  int? bandwidthLimit; // in bytes per second

  bool autoStart = false;
  
  bool isDarkMode = true;
}






