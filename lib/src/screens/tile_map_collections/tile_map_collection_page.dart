// ignore_for_file: prefer_final_parameters

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../json/app_preferences.dart';
import '../../json/flag.dart';
import '../../json/tile_map.dart';
import '../../json/tile_map_collection.dart';
import '../../widgets/cancel.dart';
import '../../widgets/get_text.dart';
import '../../widgets/tabbed_scaffold.dart';
import '../flags/edit_flag.dart';
import '../flags/flags_list.dart';
import '../tile_maps/tile_maps_list.dart';

/// A page for editing the given [tileMapCollection].
class TileMapCollectionPage extends StatefulWidget {
  /// Create an instance.
  const TileMapCollectionPage({
    required this.sharedPreferences,
    required this.appPreferences,
    required this.tileMapCollection,
    super.key,
  });

  /// Shared preferences.
  final SharedPreferences sharedPreferences;

  /// The app preferences to load collections from.
  final AppPreferences appPreferences;

  /// The collection to edit.
  final TileMapCollection tileMapCollection;

  /// Create state for this widget.
  @override
  TileMapCollectionPageState createState() => TileMapCollectionPageState();
}

/// State for [TileMapCollectionPage].
class TileMapCollectionPageState extends State<TileMapCollectionPage> {
  /// Build a widget.
  @override
  Widget build(final BuildContext context) {
    final renameButton = ElevatedButton(
      onPressed: () => pushWidget(
        context: context,
        builder: (context) => GetText(
          onDone: (value) {
            Navigator.pop(context);
            widget.tileMapCollection.name = value;
            widget.appPreferences.save(widget.sharedPreferences);
            setState(() {});
          },
          labelText: 'Collection Name',
          text: widget.tileMapCollection.name,
          title: 'Rename Collection',
        ),
      ),
      child: renameIcon,
    );
    return Cancel(
      child: TabbedScaffold(
        tabs: [
          TabbedScaffoldTab(
            title: 'Flags',
            icon: const Icon(Icons.flag),
            actions: [renameButton],
            builder: (context) => FlagsList(
              sharedPreferences: widget.sharedPreferences,
              appPreferences: widget.appPreferences,
              collection: widget.tileMapCollection,
            ),
            floatingActionButton: FloatingActionButton(
              autofocus: widget.tileMapCollection.flags.isEmpty,
              onPressed: () async {
                final flag = Flag(
                  name: 'flag${widget.tileMapCollection.flags.length}',
                  description: 'Flag ${widget.tileMapCollection.flags.length}',
                  value: widget.tileMapCollection.nextFlagValue(),
                );
                widget.tileMapCollection.flags.add(flag);
                await pushWidget(
                  context: context,
                  builder: (context) => EditFlag(
                    flag: flag,
                    deleteFlag: () {
                      widget.tileMapCollection.removeFlag(flag);
                    },
                  ),
                );
                widget.appPreferences.save(widget.sharedPreferences);
                setState(() {});
              },
              tooltip: 'New Flag',
              child: createIcon,
            ),
          ),
          TabbedScaffoldTab(
            title: 'Maps',
            icon: const Icon(Icons.map),
            actions: [renameButton],
            builder: (context) => TileMapList(
              sharedPreferences: widget.sharedPreferences,
              appPreferences: widget.appPreferences,
              collection: widget.tileMapCollection,
            ),
            floatingActionButton: FloatingActionButton(
              autofocus: widget.tileMapCollection.flags.isEmpty,
              onPressed: () async {
                final map = TileMap(id: newId(), name: 'Untitled Map');
                widget.tileMapCollection.maps.add(map);
                widget.appPreferences.save(widget.sharedPreferences);
                setState(() {});
              },
              tooltip: 'New Map',
              child: createIcon,
            ),
          )
        ],
      ),
    );
  }
}
