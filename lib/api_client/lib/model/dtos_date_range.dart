//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DtosDateRange {
  /// Returns a new [DtosDateRange] instance.
  DtosDateRange({
    required this.endDate,
    required this.startDate,
  });

  String endDate;

  String startDate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DtosDateRange &&
    other.endDate == endDate &&
    other.startDate == startDate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (endDate.hashCode) +
    (startDate.hashCode);

  @override
  String toString() => 'DtosDateRange[endDate=$endDate, startDate=$startDate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'end_date'] = this.endDate;
      json[r'start_date'] = this.startDate;
    return json;
  }

  /// Returns a new [DtosDateRange] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DtosDateRange? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DtosDateRange[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DtosDateRange[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DtosDateRange(
        endDate: mapValueOfType<String>(json, r'end_date')!,
        startDate: mapValueOfType<String>(json, r'start_date')!,
      );
    }
    return null;
  }

  static List<DtosDateRange> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DtosDateRange>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DtosDateRange.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DtosDateRange> mapFromJson(dynamic json) {
    final map = <String, DtosDateRange>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DtosDateRange.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DtosDateRange-objects as value to a dart map
  static Map<String, List<DtosDateRange>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DtosDateRange>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DtosDateRange.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'end_date',
    'start_date',
  };
}

