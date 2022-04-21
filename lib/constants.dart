import 'package:flutter/material.dart';
import 'package:short_uuids/short_uuids.dart';

const _uuid = ShortUuid();

/// Returns a new and unique ID.
String newId() => _uuid.generate();

/// The new icon.
const createIcon = Icon(
  Icons.create,
  semanticLabel: 'Create',
);

/// The delete icon.
const deleteIcon = Icon(
  Icons.delete,
  semanticLabel: 'Delete',
);

/// The icon for renaming things.
const renameIcon = Icon(
  Icons.drive_file_rename_outline,
  semanticLabel: 'Rename',
);

/// Push the result of the given [builder] onto the stack.
Future<void> pushWidget({
  required final BuildContext context,
  required final WidgetBuilder builder,
}) =>
    Navigator.of(context).push<void>(
      MaterialPageRoute(
        builder: builder,
      ),
    );
