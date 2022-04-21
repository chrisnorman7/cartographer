import 'package:json_annotation/json_annotation.dart';

part 'flag.g.dart';

/// A flag for a map tile.
@JsonSerializable()
class Flag {
  /// Create an instance.
  Flag({
    required this.name,
    required this.description,
    required this.value,
  });

  /// Create an instance from a JSON object.
  factory Flag.fromJson(final Map<String, dynamic> json) =>
      _$FlagFromJson(json);

  /// The name for this flag.
  ///
  /// This value will be used during code generation.
  String name;

  /// The description of this flag.
  ///
  /// This value will be used as the comment during code generation, and in the
  /// UI.
  String description;

  /// The value of this flag.
  ///
  /// This value will be used by tiles.
  final int value;

  /// Convert an instance to JSON.
  Map<String, dynamic> toJson() => _$FlagToJson(this);
}
