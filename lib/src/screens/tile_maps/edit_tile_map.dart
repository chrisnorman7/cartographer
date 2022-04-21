// ignore_for_file: prefer_final_parameters
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../json/app_preferences.dart';
import '../../json/flag.dart';
import '../../json/tile_map.dart';
import '../../widgets/tabbed_scaffold.dart';
import 'tile_map_editor.dart';
import 'tile_map_settings.dart';

/// A widget for editing the given [map].
class EditTileMap extends StatefulWidget {
  /// Create an instance.
  const EditTileMap({
    required this.sharedPreferences,
    required this.appPreferences,
    required this.map,
    required this.flags,
    required this.deleteMap,
    super.key,
  });

  /// The shared preferences to use.
  final SharedPreferences sharedPreferences;

  /// The app settings to use.
  final AppPreferences appPreferences;

  /// The map to edit.
  final TileMap map;

  /// The possible flags.
  final List<Flag> flags;

  /// The function to call to delete the [map].
  final VoidCallback deleteMap;

  /// Create state for this widget.
  @override
  EditTileMapState createState() => EditTileMapState();
}

/// State for [EditTileMap].
class EditTileMapState extends State<EditTileMap> {
  /// Build a widget.
  @override
  Widget build(final BuildContext context) => TabbedScaffold(
        tabs: [
          TabbedScaffoldTab(
            title: 'Settings',
            icon: const Icon(Icons.settings),
            builder: (context) => TileMapSettings(
              tileMap: widget.map,
              saveFunc: () =>
                  widget.appPreferences.save(widget.sharedPreferences),
            ),
          ),
          TabbedScaffoldTab(
            title: 'Editor',
            icon: const Icon(Icons.edit),
            builder: (context) => TileMapEditor(
              tileMap: widget.map,
              flags: widget.flags,
              saveFunc: () =>
                  widget.appPreferences.save(widget.sharedPreferences),
            ),
          )
        ],
      );
}
