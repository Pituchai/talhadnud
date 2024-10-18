//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class SlotsApi {
  SlotsApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Create a slot
  ///
  /// Create a new slot with the provided data
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [DtosSlotGenerationRequest] slot (required):
  ///   Slot data
  Future<Response> slotsCreatePostWithHttpInfo(DtosSlotGenerationRequest slot,) async {
    // ignore: prefer_const_declarations
    final path = r'/slots/create';

    // ignore: prefer_final_locals
    Object? postBody = slot;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Create a slot
  ///
  /// Create a new slot with the provided data
  ///
  /// Parameters:
  ///
  /// * [DtosSlotGenerationRequest] slot (required):
  ///   Slot data
  Future<List<EntitiesSlot>?> slotsCreatePost(DtosSlotGenerationRequest slot,) async {
    final response = await slotsCreatePostWithHttpInfo(slot,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<EntitiesSlot>') as List)
        .cast<EntitiesSlot>()
        .toList(growable: false);

    }
    return null;
  }

  /// Get all slots
  ///
  /// Get all slots
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///   Market ID
  Future<Response> slotsGetIdGetWithHttpInfo(String id,) async {
    // ignore: prefer_const_declarations
    final path = r'/slots/get/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get all slots
  ///
  /// Get all slots
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///   Market ID
  Future<EntitiesSlot?> slotsGetIdGet(String id,) async {
    final response = await slotsGetIdGetWithHttpInfo(id,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'EntitiesSlot',) as EntitiesSlot;
    
    }
    return null;
  }

  /// Get slots by date
  ///
  /// Get slots by date
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] marketID (required):
  ///   MarketID
  ///
  /// * [String] date (required):
  ///   Date
  Future<Response> slotsMarketsMarketIDDateDateGetWithHttpInfo(String marketID, String date,) async {
    // ignore: prefer_const_declarations
    final path = r'/slots/markets/{marketID}/date/{date}'
      .replaceAll('{marketID}', marketID)
      .replaceAll('{date}', date);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
    );
  }

  /// Get slots by date
  ///
  /// Get slots by date
  ///
  /// Parameters:
  ///
  /// * [String] marketID (required):
  ///   MarketID
  ///
  /// * [String] date (required):
  ///   Date
  Future<List<EntitiesSlot>?> slotsMarketsMarketIDDateDateGet(String marketID, String date,) async {
    final response = await slotsMarketsMarketIDDateDateGetWithHttpInfo(marketID, date,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      final responseBody = await _decodeBodyBytes(response);
      return (await apiClient.deserializeAsync(responseBody, 'List<EntitiesSlot>') as List)
        .cast<EntitiesSlot>()
        .toList(growable: false);

    }
    return null;
  }
}
