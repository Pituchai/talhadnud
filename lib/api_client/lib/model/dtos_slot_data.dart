//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DtosSlotData {
  /// Returns a new [DtosSlotData] instance.
  DtosSlotData({
    required this.category,
    required this.price,
    required this.slotId,
    required this.status,
  });

  EntitiesCategory category;

  num price;

  String slotId;

  EntitiesSlotStatus status;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DtosSlotData &&
    other.category == category &&
    other.price == price &&
    other.slotId == slotId &&
    other.status == status;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (category.hashCode) +
    (price.hashCode) +
    (slotId.hashCode) +
    (status.hashCode);

  @override
  String toString() => 'DtosSlotData[category=$category, price=$price, slotId=$slotId, status=$status]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'category'] = this.category;
      json[r'price'] = this.price;
      json[r'slot_id'] = this.slotId;
      json[r'status'] = this.status;
    return json;
  }

  /// Returns a new [DtosSlotData] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DtosSlotData? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key), 'Required key "DtosSlotData[$key]" is missing from JSON.');
          assert(json[key] != null, 'Required key "DtosSlotData[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DtosSlotData(
        category: EntitiesCategory.fromJson(json[r'category'])!,
        price: num.parse('${json[r'price']}'),
        slotId: mapValueOfType<String>(json, r'slot_id')!,
        status: EntitiesSlotStatus.fromJson(json[r'status'])!,
      );
    }
    return null;
  }

  static List<DtosSlotData> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DtosSlotData>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DtosSlotData.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DtosSlotData> mapFromJson(dynamic json) {
    final map = <String, DtosSlotData>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DtosSlotData.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DtosSlotData-objects as value to a dart map
  static Map<String, List<DtosSlotData>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DtosSlotData>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DtosSlotData.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'category',
    'price',
    'slot_id',
    'status',
  };
}

