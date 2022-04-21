import 'package:json_annotation/json_annotation.dart';

import 'flag.dart';
import 'tile_map.dart';

part 'tile_map_collection.g.dart';

/// A collection of tile [maps].
@JsonSerializable()
class TileMapCollection {
  /// Create an instance.
  TileMapCollection({
    required this.id,
    required this.name,
    required this.flags,
    required this.maps,
  });

  /// Create an instance from a JSON object.
  factory TileMapCollection.fromJson(final Map<String, dynamic> json) =>
      _$TileMapCollectionFromJson(json);

  /// The ID of this collection.
  final String id;

  /// The name of this collection.
  String name;

  /// The flags to use.
  final List<Flag> flags;

  /// The tile maps that belong to this collection.
  final List<TileMap> maps;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$TileMapCollectionToJson(this);

  /// Remove the given [flag].
  void removeFlag(final Flag flag) {
    flags.remove(flag);
    for (final map in maps) {
      for (final tileList in map.tiles) {
        for (var i = 0; i < tileList.length; i++) {
          final value = tileList[i];
          if (value & flag.value != 0) {
            tileList[i] -= flag.value;
          }
        }
      }
    }
  }

  /// Get the next valid value for a new flag.
  int nextFlagValue() {
    var i = 1;
    for (final flag in flags) {
      if (flag.value != i) {
        return i;
      }
      i *= 2;
    }
    return i;
  }
}
