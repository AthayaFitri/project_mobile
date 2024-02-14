// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_courses.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataCoursesHiveAdapter extends TypeAdapter<DataCoursesHive> {
  @override
  final int typeId = 0;

  @override
  DataCoursesHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataCoursesHive(
      id: fields[0] as int,
      isFavorite: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, DataCoursesHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataCoursesHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
