//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DtosUpdateUserRequest {
  /// Returns a new [DtosUpdateUserRequest] instance.
  ///   String? username;
  String? email;
  String? first_name;
  String? last_name;
  String? phone;
  String? image;
  String? username;

  DtosUpdateUserRequest({
    this.username,
    this.email,
    this.first_name,
    this.last_name,
    this.phone,
    this.image,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DtosUpdateUserRequest &&
          other.email == email &&
          other.first_name == first_name &&
          other.last_name == last_name &&
          other.username == username &&
          other.phone == phone &&
          other.image == image;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (email == null ? 0 : email!.hashCode) +
      (first_name == null ? 0 : first_name!.hashCode) +
      (last_name == null ? 0 : last_name!.hashCode) +
      (username == null ? 0 : username!.hashCode) +
      (phone == null ? 0 : phone!.hashCode) +
      (image == null ? 0 : image!.hashCode);

  @override
  String toString() =>
      'DtosUpdateUserRequest[email=$email, first_name=$first_name, last_name=$last_name, username=$username ,phone=$phone, image=$image]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (email != null) {
      json[r'email'] = email;
    }
    if (first_name != null) {
      json[r'first_name'] = first_name;
    }
    if (last_name != null) {
      json[r'lastName'] = last_name;
    }
    if (username != null) {
      json[r'username'] = username;
    }
    if (phone != null) {
      json[r'phone'] = phone;
    }
    if (image != null) {
      json[r'image'] = image;
    }
    return json;
  }

  /// Returns a new [DtosUpdateUserRequest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DtosUpdateUserRequest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "DtosUpdateUserRequest[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "DtosUpdateUserRequest[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return DtosUpdateUserRequest(
        email: json[r'email'] as String?,
        first_name: json[r'first_name'] as String?,
        last_name: json[r'last_name'] as String?,
        username: json[r'username'] as String?,
        phone: json[r'phone'] as String?,
        image: json[r'image'] as String?,
        
      );
    }
    return null;
  }

  static List<DtosUpdateUserRequest> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <DtosUpdateUserRequest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DtosUpdateUserRequest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DtosUpdateUserRequest> mapFromJson(dynamic json) {
    final map = <String, DtosUpdateUserRequest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DtosUpdateUserRequest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DtosUpdateUserRequest-objects as value to a dart map
  static Map<String, List<DtosUpdateUserRequest>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<DtosUpdateUserRequest>>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        map[entry.key] = DtosUpdateUserRequest.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{};
}
