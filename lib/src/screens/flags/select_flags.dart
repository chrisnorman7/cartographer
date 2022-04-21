// ignore_for_file: prefer_final_parameters
import 'package:flutter/material.dart';

import '../../json/flag.dart';
import '../../widgets/cancel.dart';
import '../../widgets/simple_scaffold.dart';

/// A widget for selecting possible flags.
class SelectFlags extends StatefulWidget {
  /// Create an instance.
  const SelectFlags({
    required this.value,
    required this.flags,
    required this.onChanged,
    super.key,
  });

  /// The current value.
  final int value;

  /// The flags to choose from.
  final List<Flag> flags;

  /// The function to call when changing [value].
  final ValueChanged<int> onChanged;

  /// Create state for this widget.
  @override
  SelectFlagsState createState() => SelectFlagsState();
}

/// State for [SelectFlags].
class SelectFlagsState extends State<SelectFlags> {
  int? _value;

  /// Build a widget.
  @override
  Widget build(final BuildContext context) {
    var value = _value ?? widget.value;
    _value = value;
    return Cancel(
      child: SimpleScaffold(
        title: 'Select Flags',
        body: ListView.builder(
          itemBuilder: (context, index) {
            final flag = widget.flags[index];
            final isSet = value & flag.value != 0;
            return CheckboxListTile(
              value: isSet,
              onChanged: (checked) {
                if (checked ?? true) {
                  value |= flag.value;
                } else {
                  value -= flag.value;
                }
                widget.onChanged(value);
                setState(() => _value = value);
              },
              autofocus: index == 0,
              title: Text('${isSet ? "Unset" : "Set"} ${flag.description}'),
            );
          },
          itemCount: widget.flags.length,
        ),
      ),
    );
  }
}
