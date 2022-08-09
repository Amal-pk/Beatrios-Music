// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'music_db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlaylistmodelAdapter extends TypeAdapter<Playlistmodel> {
  @override
  final int typeId = 1;

  @override
  Playlistmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Playlistmodel(
      songid: (fields[0] as List).cast<int>(),
      name: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Playlistmodel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.songid)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlaylistmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
