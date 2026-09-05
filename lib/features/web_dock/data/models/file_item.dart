import 'package:isar/isar.dart';

part 'file_item.g.dart';

@collection
class FileItem {
  Id id = Isar.autoIncrement;

  @Index()
  late String virtualPath;

  @Index()
  late String physicalPath;

  @Index(type: IndexType.value, caseSensitive: false)
  late String name;

  late int size;
  late DateTime modifiedAt;
  late bool isDirectory;
  
  String? mimeType;
  
  @Index()
  late String fileType; // video, audio, image, document, archive, other

  @Index()
  late int parentId; // ID of the parent SharedFolder or parent FileItem (if nested)
}






