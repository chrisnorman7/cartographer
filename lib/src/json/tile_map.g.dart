// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tile_map.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TileMap _$TileMapFromJson(Map<String, dynamic> json) => TileMap(
      id: json['id'] as String,
      name: json['name'] as String,
      xSize: json['xSize'] as int? ?? 10,
      ySize: json['ySize'] as int? ?? 10,
      tiles: (json['tiles'] as List<dynamic>?)
          ?.map((e) => (e as List<dynamic>).map((e) => e as int).toList())
          .toList(),
    );

Map<String, dynamic> _$TileMapToJson(TileMap instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'xSize': instance.xSize,
      'ySize': instance.ySize,
      'tiles': instance.tiles,
    };
