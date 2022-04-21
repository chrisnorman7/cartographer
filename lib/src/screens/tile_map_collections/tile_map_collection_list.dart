// ignore_for_file: prefer_final_parameters
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../json/app_preferences.dart';
import '../../json/tile_map_collection.dart';
import '../../widgets/center_text.dart';
import '../../widgets/simple_scaffold.dart';
import 'tile_map_collection_page.dart';

/// A widget for showing tile map collections.
class TileMapCollectionList extends StatefulWidget {
  /// Create an instance.
  const TileMapCollectionList({
    required this.sharedPreferences,
    required this.appPreferences,
    super.key,
  });

  /// Shared preferences.
  final SharedPreferences sharedPreferences;

  /// The app preferences to load collections from.
  final AppPreferences appPreferences;

  /// Create state for this widget.
  @override
  TileMapCollectionListState createState() => TileMapCollectionListState();
}

/// State for [TileMapCollectionList].
class TileMapCollectionListState extends State<TileMapCollectionList> {
  /// Build a widget.
  @override
  Widget build(final BuildContext context) {
    final collections = widget.appPreferences.collections;
    final Widget child;
    if (collections.isEmpty) {
      child = const CenterText(
        text: 'You have not created any collections yet.',
        autofocus: false,
      );
    } else {
      child = ListView.builder(
        itemBuilder: (context, index) {
          final collection = collections[index];
          return ListTile(
            autofocus: index == 0,
            title: Text(collection.name),
            onTap: () async {
              await pushWidget(
                context: context,
                builder: (context) => TileMapCollectionPage(
                  sharedPreferences: widget.sharedPreferences,
                  appPreferences: widget.appPreferences,
                  tileMapCollection: collection,
                ),
              );
              setState(() {});
            },
          );
        },
        itemCount: collections.length,
      );
    }
    return SimpleScaffold(
      title: 'Tile Map Collections',
      body: child,
      floatingActionButton: FloatingActionButton(
        autofocus: collections.isEmpty,
        onPressed: () {
          final collection = TileMapCollection(
            id: newId(),
            name: 'Untitled Collection',
            flags: [],
            maps: [],
          );
          widget.appPreferences.collections.add(collection);
          widget.appPreferences.save(widget.sharedPreferences);
          setState(() {});
        },
        tooltip: 'New Collection',
        child: createIcon,
      ),
    );
  }
}
