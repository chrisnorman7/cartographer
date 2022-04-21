import 'package:cartographer/src/json/tile_map.dart';
import 'package:cartographer/src/json/tile_map_collection.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../flags.dart';

void main() {
  group(
    'TileMapCollection',
    () {
      test(
        '.removeFlag',
        () {
          final map1 = TileMap(id: 'map1', name: 'Map 1');
          final map2 = TileMap(id: 'map2', name: 'Map 2', xSize: 15, ySize: 20);
          final collection = TileMapCollection(
            id: 'collection',
            name: 'Test Collection',
            flags: [grass, mud],
            maps: [map1, map2],
          );
          expect(collection.flags, [grass, mud]);
          map1.setFlag(0, 0, grass);
          map2.setFlag(0, 0, mud);
          collection.removeFlag(grass);
          expect(collection.flags, [mud]);
          expect(map1.getTile(0, 0), isZero);
          expect(map2.getTile(0, 0), mud.value);
        },
      );
    },
  );
}
