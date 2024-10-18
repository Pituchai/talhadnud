# openapi.api.SlotsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**slotsCreatePost**](SlotsApi.md#slotscreatepost) | **POST** /slots/create | Create a slot
[**slotsGetIdGet**](SlotsApi.md#slotsgetidget) | **GET** /slots/get/{id} | Get all slots
[**slotsMarketsMarketIDDateDateGet**](SlotsApi.md#slotsmarketsmarketiddatedateget) | **GET** /slots/markets/{marketID}/date/{date} | Get slots by date


# **slotsCreatePost**
> List<EntitiesSlot> slotsCreatePost(slot)

Create a slot

Create a new slot with the provided data

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = SlotsApi();
final slot = DtosSlotGenerationRequest(); // DtosSlotGenerationRequest | Slot data

try {
    final result = api_instance.slotsCreatePost(slot);
    print(result);
} catch (e) {
    print('Exception when calling SlotsApi->slotsCreatePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **slot** | [**DtosSlotGenerationRequest**](DtosSlotGenerationRequest.md)| Slot data | 

### Return type

[**List<EntitiesSlot>**](EntitiesSlot.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **slotsGetIdGet**
> EntitiesSlot slotsGetIdGet(id)

Get all slots

Get all slots

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = SlotsApi();
final id = id_example; // String | Market ID

try {
    final result = api_instance.slotsGetIdGet(id);
    print(result);
} catch (e) {
    print('Exception when calling SlotsApi->slotsGetIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Market ID | 

### Return type

[**EntitiesSlot**](EntitiesSlot.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **slotsMarketsMarketIDDateDateGet**
> List<EntitiesSlot> slotsMarketsMarketIDDateDateGet(marketID, date)

Get slots by date

Get slots by date

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = SlotsApi();
final marketID = marketID_example; // String | MarketID
final date = date_example; // String | Date

try {
    final result = api_instance.slotsMarketsMarketIDDateDateGet(marketID, date);
    print(result);
} catch (e) {
    print('Exception when calling SlotsApi->slotsMarketsMarketIDDateDateGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **marketID** | **String**| MarketID | 
 **date** | **String**| Date | 

### Return type

[**List<EntitiesSlot>**](EntitiesSlot.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

