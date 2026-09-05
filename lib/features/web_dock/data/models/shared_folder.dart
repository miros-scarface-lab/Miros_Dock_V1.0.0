import 'package:isar/isar.dart';

part 'shared_folder.g.dart';

@collection
class SharedFolder {
  Id id = Isar.autoIncrement;

  @Index(unique: true)
  late String physicalPath;

  @Index(unique: true)
  late String virtualPath;

  late String name;

  DateTime addedAt = DateTime.now();
}






