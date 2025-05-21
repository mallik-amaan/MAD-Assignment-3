// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_deal_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GameDealModelAdapter extends TypeAdapter<GameDealModel> {
  @override
  final int typeId = 0;

  @override
  GameDealModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GameDealModel(
      gameID: fields[0] as String?,
      title: fields[1] as String?,
      thumb: fields[2] as String?,
      normalPrice: fields[3] as String?,
      salePrice: fields[4] as String?,
      savings: fields[5] as String?,
      releaseDate: fields[6] as String?,
      dealRating: fields[7] as String?,
      isSaved: fields[8] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, GameDealModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.gameID)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.thumb)
      ..writeByte(3)
      ..write(obj.normalPrice)
      ..writeByte(4)
      ..write(obj.salePrice)
      ..writeByte(5)
      ..write(obj.savings)
      ..writeByte(6)
      ..write(obj.releaseDate)
      ..writeByte(7)
      ..write(obj.dealRating)
      ..writeByte(8)
      ..write(obj.isSaved);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GameDealModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
