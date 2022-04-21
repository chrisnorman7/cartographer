// ignore_for_file: prefer_final_parameters

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'src/json/app_preferences.dart';
import 'src/screens/tile_map_collections/tile_map_collection_list.dart';
import 'src/widgets/loading.dart';

void main() => runApp(const MyApp());

/// The main app class.
class MyApp extends StatelessWidget {
  /// Create an instance.
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(final BuildContext context) {
    if (kIsWeb) {
      RendererBinding.instance.setSemanticsEnabled(true);
    }
    return MaterialApp(
      title: 'Cartographer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

/// The home page for the application.
class HomePage extends StatefulWidget {
  /// Create an instance.
  const HomePage({
    super.key,
  });

  /// Create state for this widget.
  @override
  HomePageState createState() => HomePageState();
}

/// State for [HomePage].
class HomePageState extends State<HomePage> {
  SharedPreferences? _sharedPreferences;
  AppPreferences? _appPreferences;

  /// Build a widget.
  @override
  Widget build(final BuildContext context) {
    final sharedPreferences = _sharedPreferences;
    if (sharedPreferences == null) {
      loadPreferences();
      return const LoadingScaffold(
        loadingMessage: 'Loading shared preferences...',
        title: 'App Starting',
      );
    }
    var appPreferences = _appPreferences;
    if (appPreferences == null) {
      appPreferences = AppPreferences.fromSharedPreferences(sharedPreferences);
      _appPreferences = appPreferences;
    }
    return TileMapCollectionList(
      sharedPreferences: sharedPreferences,
      appPreferences: appPreferences,
    );
  }

  /// Load shared preferences.
  Future<void> loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _sharedPreferences = prefs;
    });
  }
}
