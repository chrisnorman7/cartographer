import 'package:cartographer/src/json/tile_map.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:short_uuids/short_uuids.dart';

import '../../flags.dart';

const _uuid = ShortUuid();
void main() {
  group(
    'TileMap',
    () {
      test(
        'Initialise',
        () {
          final map = TileMap(
            id: _uuid.generate(),
            name: 'Test Map',
            ySize: 11,
          );
          expect(map.tiles.length, 10);
          for (var i = 0; i < map.xSize; i++) {
            final tileList = map.tiles[i];
            expect(tileList.length, 11);
          }
        },
      );

      test(
        '.resize',
        () {
          final map = TileMap(
            id: _uuid.generate(),
            name: 'Big Map',
            xSize: 100,
            ySize: 100,
          );
          expect(map.tiles.length, 100);
          map.resize(x: 50, y: 75);
          expect(map.tiles.length, 50);
          for (var i = 0; i < map.xSize; i++) {
            final tileList = map.tiles[i];
            expect(tileList.length, map.ySize);
          }
        },
      );

      test(
        'Tiles',
        () {
          final map = TileMap(
            id: _uuid.generate(),
            name: 'Test Map',
          );
          expect(map.getTile(0, 0), isZero);
          map.setFlag(0, 0, grass);
          expect(map.getTile(0, 0), grass.value);
          expect(map.getTile(1, 3), isZero);
          map.setFlag(0, 0, mud);
          expect(map.getTile(0, 0), grass.value | mud.value);
          expect(map.getTile(2, 5), isZero);
          map.unsetFlag(0, 0, grass);
          expect(map.getTile(0, 0), mud.value);
          expect(map.getTile(5, 8), isZero);
          map.setFlag(2, 4, grass);
          expect(map.getTile(0, 0), mud.value);
          expect(map.getTile(2, 4), grass.value);
          map.unsetFlag(2, 4, grass);
          expect(map.getTile(2, 4), isZero);
        },
      );
    },
  );
}
