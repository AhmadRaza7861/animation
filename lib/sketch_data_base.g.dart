// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sketch_data_base.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SketchDatabaseAdapter extends TypeAdapter<SketchDatabase> {
  @override
  final int typeId = 1;

  @override
  SketchDatabase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SketchDatabase(
      projectName: fields[0] as String,
      sketchdata: (fields[1] as List).cast<String>(),
      imagesList: (fields[2] as List).cast<Uint8List>(),
    );
  }

  @override
  void write(BinaryWriter writer, SketchDatabase obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.projectName)
      ..writeByte(1)
      ..write(obj.sketchdata)
      ..writeByte(2)
      ..write(obj.imagesList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SketchDatabaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
