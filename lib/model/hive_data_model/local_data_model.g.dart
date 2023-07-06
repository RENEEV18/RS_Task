// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GetLocalDataModelAdapter extends TypeAdapter<GetLocalDataModel> {
  @override
  final int typeId = 1;

  @override
  GetLocalDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GetLocalDataModel(
      id: fields[0] as int,
      name: fields[1] as String,
      description: fields[2] as String,
      watchersCount: fields[5] as int,
      language: fields[3] as dynamic,
      openIssuesCount: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, GetLocalDataModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.language)
      ..writeByte(4)
      ..write(obj.openIssuesCount)
      ..writeByte(5)
      ..write(obj.watchersCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GetLocalDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
