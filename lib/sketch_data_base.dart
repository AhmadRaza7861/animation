import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

part 'sketch_data_base.g.dart';

@HiveType(typeId: 1)
class SketchDatabase {
  SketchDatabase({required this.projectName,required this.sketchdata,required this.imagesList});
  @HiveField(0)
  String projectName;

  @HiveField(1)
  List<String> sketchdata;
  @HiveField(2)
  List<Uint8List> imagesList;
}