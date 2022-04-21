import 'package:json_annotation/json_annotation.dart';

import 'flag.dart';

part 'tile_map.g.dart';

/// A map that holds lists of [tiles].
@JsonSerializable()
class TileMap {
  /// Create an instance.
  TileMap({
    required this.id,
    required this.name,
    this.xSize = 10,
    this.ySize = 10,
    final List<List<int>>? tiles,
  }) : tiles = tiles ??
            List.generate(
              xSize,
              (final index) => List.filled(ySize, 0, growable: true),
            );

  /// Create an instance from a JSON object.
  factory TileMap.fromJson(final Map<String, dynamic> json) =>
      _$TileMapFromJson(json);

  /// The ID of this map.
  final String id;

  /// The name of this map.
  String name;

  /// The horizontal size of this map.
  int xSize;

  /// The depth of this map.
  int ySize;

  /// The tiles that belong to this map.
  final List<List<int>> tiles;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$TileMapToJson(this);

  /// Trim the given [list] to [size].
  void trim<T>({
    required final List<T> list,
    required final int size,
    required final T Function() defaultValue,
  }) {
    while (list.length > size) {
      list.removeLast();
    }
    while (list.length < size) {
      list.add(defaultValue());
    }
  }

  /// Resize this map.
  ///
  /// This method should be called to change the values of [xSize] and [ySize]
  /// to [x] and [y] respectively.
  void resize({required final int x, required final int y}) {
    xSize = x;
    ySize = y;
    trim(
      list: tiles,
      size: xSize,
      defaultValue: () => List.generate(
        x,
        (final index) => 0,
      ),
    );
    for (final tileList in tiles) {
      trim(list: tileList, size: ySize, defaultValue: () => 0);
    }
  }

  /// Add a [flag] to the tile at the given [x] and [y] position.
  void setFlag(final int x, final int y, final Flag flag) {
    tiles[x][y] |= flag.value;
  }

  /// Remove a [flag] from the given [x] and [y] coordinates.
  ///
  /// This method does not do any checking, so if you remove a flag that has not
  /// be previously set with [setFlag], then the resulting value will not be
  /// what you want, and may even become negative.
  void unsetFlag(final int x, final int y, final Flag flag) {
    tiles[x][y] -= flag.value;
  }

  /// Returns `true` if the tile at the given [x] and [y] coordinates has the
  /// given [flag].
  bool isSet(final int x, final int y, final Flag flag) =>
      tiles[x][y] & flag.value != 0;

  /// Get the raw value of the tile at the given [x] and [y] coordinates.
  int getTile(final int x, final int y) => tiles[x][y];
}
