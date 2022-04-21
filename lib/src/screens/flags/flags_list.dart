// ignore_for_file: prefer_final_parameters

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';
import '../../json/app_preferences.dart';
import '../../json/tile_map_collection.dart';
import '../../widgets/center_text.dart';
import 'edit_flag.dart';

/// Show the list of flags for the given [collection].
class FlagsList extends StatefulWidget {
  /// Create an instance.
  const FlagsList({
    required this.sharedPreferences,
    required this.appPreferences,
    required this.collection,
    super.key,
  });

  /// Shared preferences.
  final SharedPreferences sharedPreferences;

  /// The app preferences to save.
  final AppPreferences appPreferences;

  /// The collection whose flags should be edited.
  final TileMapCollection collection;

  /// Create state for this widget.
  @override
  FlagsListState createState() => FlagsListState();
}

/// State for [FlagsList].
class FlagsListState extends State<FlagsList> {
  /// Build a widget.
  @override
  Widget build(final BuildContext context) {
    final flags = widget.collection.flags
      ..sort(
        (a, b) => a.value.compareTo(b.value),
      );
    if (flags.isEmpty) {
      return const CenterText(
        text: "You haven't created any flags yet.",
        autofocus: false,
      );
    }
    return ListView.builder(
      itemBuilder: (final context, final index) {
        final flag = flags[index];
        return ListTile(
          autofocus: index == 0,
          title: Text(flag.description),
          subtitle: Text(flag.name),
          onTap: () async {
            await pushWidget(
              context: context,
              builder: (context) => EditFlag(
                flag: flag,
                deleteFlag: () {
                  widget.collection.removeFlag(flag);
                },
              ),
            );
            widget.appPreferences.save(widget.sharedPreferences);
            setState(() {});
          },
        );
      },
      itemCount: flags.length,
    );
  }
}
