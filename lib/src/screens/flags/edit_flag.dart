// ignore_for_file: prefer_final_parameters

import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../json/flag.dart';
import '../../widgets/cancel.dart';
import '../../widgets/simple_scaffold.dart';
import '../../widgets/text_list_tile.dart';

/// A widget for editing the given [flag].
class EditFlag extends StatefulWidget {
  /// Create an instance.
  const EditFlag({
    required this.flag,
    required this.deleteFlag,
    super.key,
  });

  /// The flag to edit.
  final Flag flag;

  /// The method to call to delete [flag].
  final VoidCallback deleteFlag;

  /// Create state for this widget.
  @override
  EditFlagState createState() => EditFlagState();
}

/// State for [EditFlag].
class EditFlagState extends State<EditFlag> {
  /// Build a widget.
  @override
  Widget build(final BuildContext context) => Cancel(
        child: SimpleScaffold(
          title: 'Edit Flag',
          body: ListView(
            children: [
              TextListTile(
                value: widget.flag.name,
                onChanged: (value) {
                  widget.flag.name = value;
                  setState(() {});
                },
                header: 'Name',
                autofocus: true,
              ),
              TextListTile(
                value: widget.flag.description,
                onChanged: (value) {
                  widget.flag.description = value;
                  setState(() {});
                },
                header: 'Description',
              )
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                widget.deleteFlag();
              },
              child: deleteIcon,
            )
          ],
        ),
      );
}
