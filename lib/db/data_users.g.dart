// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_users.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DataUsersHiveAdapter extends TypeAdapter<DataUsersHive> {
  @override
  final int typeId = 1;

  @override
  DataUsersHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DataUsersHive(
      userId: fields[0] as String,
      name: fields[1] as String,
      email: fields[2] as String,
      mobile: fields[3] as String,
      password: fields[4] as String,
      fcmToken: fields[5] as String,
      status: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, DataUsersHive obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.mobile)
      ..writeByte(4)
      ..write(obj.password)
      ..writeByte(5)
      ..write(obj.fcmToken)
      ..writeByte(6)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataUsersHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
