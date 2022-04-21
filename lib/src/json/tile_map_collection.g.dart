// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tile_map_collection.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TileMapCollection _$TileMapCollectionFromJson(Map<String, dynamic> json) =>
    TileMapCollection(
      id: json['id'] as String,
      name: json['name'] as String,
      flags: (json['flags'] as List<dynamic>)
          .map((e) => Flag.fromJson(e as Map<String, dynamic>))
          .toList(),
      maps: (json['maps'] as List<dynamic>)
          .map((e) => TileMap.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TileMapCollectionToJson(TileMapCollection instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'flags': instance.flags,
      'maps': instance.maps,
    };
