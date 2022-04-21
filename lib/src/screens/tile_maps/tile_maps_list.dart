// ignore_for_file: prefer_final_parameters
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../json/app_preferences.dart';
import '../../json/tile_map_collection.dart';
import '../../widgets/center_text.dart';
import 'edit_tile_map.dart';

/// A widget to show the tile maps for the given [collection].
class TileMapList extends StatefulWidget {
  /// Create an instance.
  const TileMapList({
    required this.sharedPreferences,
    required this.appPreferences,
    required this.collection,
    super.key,
  });

  /// Shared preferences.
  final SharedPreferences sharedPreferences;

  /// The app preferences to save.
  final AppPreferences appPreferences;

  /// The collection to get maps from.
  final TileMapCollection collection;

  /// Create state for this widget.
  @override
  TileMapListState createState() => TileMapListState();
}

/// State for [TileMapList].
class TileMapListState extends State<TileMapList> {
  /// Build a widget.
  @override
  Widget build(final BuildContext context) {
    final maps = widget.collection.maps
      ..sort(
        (a, b) => a.name.compareTo(b.name),
      );
    if (maps.isEmpty) {
      return const CenterText(
        text: "You haven't created any maps yet.",
        autofocus: false,
      );
    }
    return ListView.builder(
      itemBuilder: (context, index) {
        final map = maps[index];
        return ListTile(
          autofocus: index == 0,
          title: Text(map.name),
          subtitle: Text('${map.xSize} x ${map.ySize}'),
          onTap: () async {
            await pushWidget(
              context: context,
              builder: (context) => EditTileMap(
                sharedPreferences: widget.sharedPreferences,
                appPreferences: widget.appPreferences,
                map: map,
                flags: widget.collection.flags,
                deleteMap: () {
                  widget.collection.maps.removeWhere(
                    (element) => element.id == map.id,
                  );
                },
              ),
            );
            widget.appPreferences.save(widget.sharedPreferences);
            setState(() {});
          },
        );
      },
      itemCount: maps.length,
    );
  }
}
