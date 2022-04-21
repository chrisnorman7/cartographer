// ignore_for_file: prefer_final_parameters
import 'dart:io';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../constants.dart';
import '../../json/flag.dart';
import '../../json/tile_map.dart';
import '../flags/select_flags.dart';

/// A grid for editing the given [tileMap].
class TileMapEditor extends StatefulWidget {
  /// Create an instance.
  const TileMapEditor({
    required this.tileMap,
    required this.flags,
    required this.saveFunc,
    super.key,
  });

  /// The tile map to edit.
  final TileMap tileMap;

  /// The possible flags.
  final List<Flag> flags;

  /// The function to call to save this map.
  final VoidCallback saveFunc;

  /// Create state for this widget.
  @override
  TileMapEditorState createState() => TileMapEditorState();
}

/// State for [TileMapEditor].
class TileMapEditorState extends State<TileMapEditor> {
  /// The indexes of the selected tiles.
  late final List<int> selectedIndexes;

  /// Initialise [selectedIndexes].
  @override
  void initState() {
    super.initState();
    selectedIndexes = [];
  }

  /// Build a widget.
  @override
  Widget build(final BuildContext context) {
    final xSize = widget.tileMap.xSize;
    final ySize = widget.tileMap.ySize;
    return CallbackShortcuts(
      bindings: {
        const SingleActivator(LogicalKeyboardKey.escape): () {
          if (selectedIndexes.isEmpty) {
            Navigator.pop(context);
          } else {
            setState(selectedIndexes.clear);
          }
        }
      },
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: xSize,
        ),
        itemBuilder: (context, index) {
          final coordinates = getCoordinates(index);
          final flagNames = [
            for (final flag in widget.flags)
              if (widget.tileMap.isSet(coordinates.x, coordinates.y, flag))
                flag.name
          ];
          return CallbackShortcuts(
            bindings: {
              SingleActivator(
                LogicalKeyboardKey.space,
                control: kIsWeb || !Platform.isMacOS,
                meta: !kIsWeb && Platform.isMacOS,
              ): () {
                if (selectedIndexes.contains(index)) {
                  selectedIndexes.remove(index);
                } else {
                  selectedIndexes.add(index);
                }
                setState(() {});
              }
            },
            child: GridTile(
              child: ListTile(
                autofocus: index == 0,
                title: Text('${coordinates.x}, ${coordinates.y}'),
                subtitle: Text(
                  flagNames.isEmpty ? '<No flags>' : flagNames.join(', '),
                ),
                selected: selectedIndexes.contains(index),
                onTap: () async {
                  final int currentValue;
                  if (selectedIndexes.isEmpty) {
                    currentValue = widget.tileMap.getTile(
                      coordinates.x,
                      coordinates.y,
                    );
                  } else {
                    final values = selectedIndexes.map(
                      (e) {
                        final c = getCoordinates(e);
                        return widget.tileMap.getTile(c.x, c.y);
                      },
                    )..toList();
                    currentValue = widget.flags.fold(
                      0,
                      (previousValue, flag) {
                        if (values.every((value) => value & flag.value != 0)) {
                          return previousValue | flag.value;
                        }
                        return previousValue;
                      },
                    );
                  }
                  await pushWidget(
                    context: context,
                    builder: (context) => SelectFlags(
                      value: currentValue,
                      flags: widget.flags,
                      onChanged: (value) {
                        if (selectedIndexes.isEmpty) {
                          widget.tileMap.tiles[coordinates.x][coordinates.y] =
                              value;
                        } else {
                          for (final index in selectedIndexes) {
                            final c = getCoordinates(index);
                            widget.tileMap.tiles[c.x][c.y] = value;
                          }
                          selectedIndexes.clear();
                        }
                        widget.saveFunc();
                      },
                    ),
                  );
                  setState(() {});
                },
              ),
            ),
          );
        },
        itemCount: xSize * ySize,
        reverse: true,
      ),
    );
  }

  /// Convert the given [index] to coordinates.
  Point<int> getCoordinates(int index) {
    final x = index % widget.tileMap.xSize;
    final y = (index / widget.tileMap.ySize).floor();
    return Point(x, y);
  }
}
