// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'projects_database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProjectsDatabaseAdapter extends TypeAdapter<ProjectsDatabase> {
  @override
  final int typeId = 2;

  @override
  ProjectsDatabase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProjectsDatabase(
      projectName: (fields[0] as List).cast<String>(),
      category: (fields[1] as List).cast<String>(),
      image: (fields[2] as List).cast<Uint8List>(),
    );
  }

  @override
  void write(BinaryWriter writer, ProjectsDatabase obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.projectName)
      ..writeByte(1)
      ..write(obj.category)
      ..writeByte(2)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectsDatabaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
