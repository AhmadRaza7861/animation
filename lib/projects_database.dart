import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'projects_database.g.dart';

@HiveType(typeId: 2)
class ProjectsDatabase {
  ProjectsDatabase({required this.projectName,required this.category,required this.image});
  @HiveField(0)
  List<String> projectName;
  @HiveField(1)
  List<String> category;
  @HiveField(2)
  List<Uint8List> image;
}