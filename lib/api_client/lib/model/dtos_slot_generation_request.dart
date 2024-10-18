//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DtosSlotGenerationRequest {
  /// Returns a new [DtosSlotGenerationRequest] instance.
  DtosSlotGenerationRequest({
    required this.dateRange,
    required this.marketId,
    this.slots = const [],
  });

  DtosDateRange dateRange;

  String marketId;

  List<DtosSlotData> slots;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DtosSlotGenerationRequest &&
    other.dateRange == dateRange &&
    other.marketId == marketId &&
    _deepEquality.equals(other.slots, slots);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (dateRange.hashCode) +
    (marketId.hashCode) +
    (slots.hashCode);

  @override
  String toString() => 'DtosSlotGenerationRequest[dateRange=$dateRange, marketId=$marketId, slots=$slots]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'date_range'] = this.dateRange;
      json[r'market_id'] = this.marketId;
      json[r'slots'] = this.slots;
    return json;
  }

  /// Returns a new [DtosSlotGenerationRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DtosSlotGenerationRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DtosSlotGenerationRequest[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DtosSlotGenerationRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DtosSlotGenerationRequest(
        dateRange: DtosDateRange.fromJson(json[r'date_range'])!,
        marketId: mapValueOfType<String>(json, r'market_id')!,
        slots: DtosSlotData.listFromJson(json[r'slots']),
      );
    }
    return null;
  }

  static List<DtosSlotGenerationRequest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DtosSlotGenerationRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DtosSlotGenerationRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DtosSlotGenerationRequest> mapFromJson(dynamic json) {
    final map = <String, DtosSlotGenerationRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DtosSlotGenerationRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DtosSlotGenerationRequest-objects as value to a dart map
  static Map<String, List<DtosSlotGenerationRequest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DtosSlotGenerationRequest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DtosSlotGenerationRequest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'date_range',
    'market_id',
    'slots',
  };
}

