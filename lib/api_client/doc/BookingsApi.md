# openapi.api.BookingsApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**bookingsCreatePost**](BookingsApi.md#bookingscreatepost) | **POST** /bookings/create | Create a booking
[**bookingsGetIdGet**](BookingsApi.md#bookingsgetidget) | **GET** /bookings/get/{id} | Get a booking


# **bookingsCreatePost**
> DtosBookingResponse bookingsCreatePost(booking)

Create a booking

Create a new booking with the provided data

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = BookingsApi();
final booking = DtosBookingRequest(); // DtosBookingRequest | Booking data

try {
    final result = api_instance.bookingsCreatePost(booking);
    print(result);
} catch (e) {
    print('Exception when calling BookingsApi->bookingsCreatePost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **booking** | [**DtosBookingRequest**](DtosBookingRequest.md)| Booking data | 

### Return type

[**DtosBookingResponse**](DtosBookingResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **bookingsGetIdGet**
> DtosBookingResponse bookingsGetIdGet(id)

Get a booking

Get a booking with the provided ID

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = BookingsApi();
final id = id_example; // String | Booking ID

try {
    final result = api_instance.bookingsGetIdGet(id);
    print(result);
} catch (e) {
    print('Exception when calling BookingsApi->bookingsGetIdGet: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **String**| Booking ID | 

### Return type

[**DtosBookingResponse**](DtosBookingResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

