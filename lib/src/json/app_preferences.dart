import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'tile_map_collection.dart';

part 'app_preferences.g.dart';

/// Preferences for the app.
@JsonSerializable()
class AppPreferences {
  /// Create an instance.
  AppPreferences({
    required this.collections,
  });

  /// Create an instance from a JSON object.
  factory AppPreferences.fromJson(final Map<String, dynamic> json) =>
      _$AppPreferencesFromJson(json);

  /// Load an instance from the given [sharedPreferences].
  factory AppPreferences.fromSharedPreferences(
    final SharedPreferences sharedPreferences,
  ) {
    final data = sharedPreferences.getString(key);
    if (data == null) {
      return AppPreferences(collections: []);
    }
    final json = jsonDecode(data) as Map<String, dynamic>;
    return AppPreferences.fromJson(json);
  }

  /// The key which holds JSON data.
  static const key = 'app_preferences';

  /// The maps that have been created.
  final List<TileMapCollection> collections;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$AppPreferencesToJson(this);

  /// Save preferences.
  void save(final SharedPreferences sharedPreferences) {
    final json = toJson();
    final data = jsonEncode(json);
    sharedPreferences.setString(key, data);
  }
}
