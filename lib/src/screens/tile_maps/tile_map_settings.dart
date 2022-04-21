// ignore_for_file: prefer_final_parameters
import 'package:flutter/material.dart';

import '../../json/tile_map.dart';
import '../../widgets/cancel.dart';
import '../../widgets/int_list_tile.dart';
import '../../widgets/text_list_tile.dart';

/// The main settings for the given [tileMap].
class TileMapSettings extends StatefulWidget {
  /// Create an instance.
  const TileMapSettings({
    required this.tileMap,
    required this.saveFunc,
    super.key,
  });

  /// The tile map to edit.
  final TileMap tileMap;

  /// The function to call to save the [tileMap].
  final VoidCallback saveFunc;

  /// Create state for this widget.
  @override
  TileMapSettingsState createState() => TileMapSettingsState();
}

/// State for [TileMapSettings].
class TileMapSettingsState extends State<TileMapSettings> {
  /// Build a widget.
  @override
  Widget build(BuildContext context) {
    final xSize = widget.tileMap.xSize;
    final ySize = widget.tileMap.ySize;
    return Cancel(
      child: ListView(
        children: [
          TextListTile(
            value: widget.tileMap.name,
            onChanged: (value) {
              widget.tileMap.name = value;
              save();
            },
            header: 'Name',
            autofocus: true,
          ),
          IntListTile(
            value: widget.tileMap.xSize,
            onChanged: (value) {
              widget.tileMap.resize(x: value, y: ySize);
              save();
            },
            title: 'X Size',
            min: 1,
          ),
          IntListTile(
            value: widget.tileMap.ySize,
            onChanged: (value) {
              widget.tileMap.resize(x: xSize, y: value);
              save();
            },
            title: 'Y Size',
            min: 1,
          )
        ],
      ),
    );
  }

  /// Save the map.
  void save() {
    widget.saveFunc();
    setState(() {});
  }
}
