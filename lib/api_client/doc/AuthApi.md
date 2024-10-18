# openapi.api.AuthApi

## Load the API package
```dart
import 'package:openapi/api.dart';
```

All URIs are relative to *http://localhost:3000/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**authLoginPost**](AuthApi.md#authloginpost) | **POST** /auth/login | Login
[**authRegisterPost**](AuthApi.md#authregisterpost) | **POST** /auth/register | Register


# **authLoginPost**
> EntitiesLoginResponse authLoginPost(login)

Login

Login with the provided credentials

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AuthApi();
final login = EntitiesLoginRequest(); // EntitiesLoginRequest | Login data

try {
    final result = api_instance.authLoginPost(login);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->authLoginPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **login** | [**EntitiesLoginRequest**](EntitiesLoginRequest.md)| Login data | 

### Return type

[**EntitiesLoginResponse**](EntitiesLoginResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **authRegisterPost**
> DtosRegisterResponse authRegisterPost(register)

Register

Register a new user with the provided data

### Example
```dart
import 'package:openapi/api.dart';

final api_instance = AuthApi();
final register = DtosRegisterRequest(); // DtosRegisterRequest | Register request

try {
    final result = api_instance.authRegisterPost(register);
    print(result);
} catch (e) {
    print('Exception when calling AuthApi->authRegisterPost: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **register** | [**DtosRegisterRequest**](DtosRegisterRequest.md)| Register request | 

### Return type

[**DtosRegisterResponse**](DtosRegisterResponse.md)

### Authorization

No authorization required

### HTTP request headers

 - **Content-Type**: application/json
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

