import 'package:http/http.dart';
import 'package:talhadnad/api_client/lib/api.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:talhadnad/model/market.dart';

class ApiService {
  static final ApiClient _apiClient = ApiClient();

  static void setAuthToken(String token) {
    _apiClient.addDefaultHeader('Authorization', 'Bearer $token');
  }

  static UsersApi get usersApi => UsersApi(_apiClient);
  static AuthApi get authApi => AuthApi(_apiClient);
  static BookingsApi get bookingsApi => BookingsApi(_apiClient);
}

class UserModel extends ChangeNotifier {
  String vendorId = "";
  String accessToken = "";
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  DtosRegisterResponse? registerResponse;
  DtosGetUserResponse? _vendorDetails;
  DtosGetUserResponse? get vendorDetails => _vendorDetails;

  UserModel() {
    loadUserData();
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString('access_token') ?? '';
    vendorId = prefs.getString('vendor_id') ?? '';

    if (accessToken.isNotEmpty) {
      ApiService.setAuthToken(accessToken);
      await fetchVendorDetails();
    }

    _isInitialized = true;
    notifyListeners();
  }

  Future<void> fetchVendorDetails() async {
    if (vendorId.isEmpty) {
      throw Exception('Vendor ID is missing. Please log in first.');
    }

    try {
      _vendorDetails = await getUserById(vendorId);
      print('Fetched vendor details: ${_vendorDetails?.toJson()}'); // Add this line for debugging
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching vendor details: $e');
      }
      rethrow;
    }
  }


  bool get isLogged => accessToken.isNotEmpty;

  Future<void> login(String username, String password) async {
    final api = AuthApi();
    final loginRequest =
        EntitiesLoginRequest(password: password, usernameOrEmail: username);

    try {
      var res = await api.authLoginPostWithHttpInfo(loginRequest);

      if (res.statusCode == 200) {
        final Map<String, dynamic> userData = jsonDecode(res.body);
        vendorId = userData['vendor_id'] ?? '';
        accessToken = userData['access_token'] ?? '';

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', accessToken);
        await prefs.setString('vendor_id', vendorId);

        ApiService.setAuthToken(accessToken);

        await fetchVendorDetails();

        _isInitialized = true;
        notifyListeners();

        if (kDebugMode) {
          print('Login successful');
        }
      } else {
        if (kDebugMode) {
          print('Login failed with status code: ${res.statusCode}');
        }
        throw Exception('Login failed: ${res.statusCode}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error during login: $e');
      }
      rethrow;
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('vendor_id');
    accessToken = "";
    vendorId = "";
    _vendorDetails = null;
    _isInitialized = false;
    notifyListeners();
  }


  Future<void> updateProfile(DtosUpdateUserRequest updateRequest) async {
    try {
      print('Updating profile for user ID: $vendorId');
      print('Update request: ${jsonEncode(updateRequest.toJson())}');

      final updatedUser =
          await ApiService.usersApi.usersIdPut(vendorId, updateRequest);

      if (updatedUser == null) {
        throw Exception('No response received from the server');
      }

      print('Updated user data: ${jsonEncode(updatedUser.toJson())}');

      // Update the local vendor details with the response from the server
      _vendorDetails = updatedUser;
      notifyListeners();
      print('Profile updated successfully');
    } on ApiException catch (e) {
      print('API Exception: Code ${e.code}, Message: ${e.message}');
      rethrow;
    } catch (e) {
      print('Error updating profile: $e');
      rethrow;
    }
  }

  DtosGetUserResponse? getCurrentUserDetails() {
    if (_vendorDetails == null) {
      fetchVendorDetails();
    }
    return _vendorDetails;
  }

  Future<DtosGetUserResponse?> getUserById(String id) async {
    try {
      if (kDebugMode) {
        print('Fetching user with ID: $id');
        print('Current access token: $accessToken');
      }

      if (accessToken.isEmpty) {
        throw Exception('Access token is missing. Please log in first.');
      }

      DtosGetUserResponse? res = await ApiService.usersApi.usersIdGet(id);
      return res;
    } catch (e) {
      if (kDebugMode) {
        print('Error in getUserById: $e');
        if (e is ApiException) {
          print('API Exception details:');
          print('Status code: ${e.code}');
          print('Response body: ${e.message}');
        }
      }
      rethrow;
    }
  }

  Future<Response> createBooking(DtosBookingRequest booking) async {
    try {
      Response res =
          await ApiService.bookingsApi.bookingsCreatePostWithHttpInfo(booking);
      if (kDebugMode) {
        print('Booking created successfully: ${res.toString()}');
      }
      return res;
    } catch (e) {
      if (kDebugMode) {
        print('Error in createBooking: $e');
      }
      rethrow;
    }
  }

  Future<List<EntitiesSlot>?> getSlotsByMarketIdAndDate(
      String marketId, String date) async {
    try {
      return await SlotsApi().slotsMarketsMarketIDDateDateGet(marketId, date);
    } catch (e) {
      if (kDebugMode) {
        print('Error in getSlotsByMarketIdAndDate: $e');
      }
      rethrow;
    }
  }

  Future<void> getUserData() async {
    if (accessToken.isEmpty) {
      if (kDebugMode) {
        print('Access token is missing');
      }
      return;
    }

    try {
      var res = await ApiService.usersApi.usersIdGetWithHttpInfo(vendorId);
      var userData = jsonDecode(res.body);
      userData.forEach((key, value) {
        if (kDebugMode) {
          print("$key: $value");
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error in getUserData: $e');
      }
      rethrow;
    }
  }

  Future<Market> getMarketById(String id) async {
    try {
      var res = await MarketApi().marketsGetIdGetWithHttpInfo(id);
      var jsonResponse = jsonDecode(res.body);

      if (jsonResponse['status'] == 'success') {
        return Market.fromJson(jsonResponse['data']);
      } else {
        throw Exception('Failed to fetch market: ${jsonResponse['message']}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in getMarketById: $e');
      }
      rethrow;
    }
  }

  Future<List<Market>> getAllMarkets() async {
    try {
      var res = await MarketApi().marketsGetGetWithHttpInfo();
      var jsonResponse = jsonDecode(res.body);

      if (jsonResponse['status'] == 'success') {
        List<dynamic> marketsList = jsonResponse['data'];
        return marketsList
            .map((marketJson) => Market.fromJson(marketJson))
            .toList();
      } else {
        throw Exception('Failed to fetch markets: ${jsonResponse['message']}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error in getAllMarkets: $e');
      }
      rethrow;
    }
  }

  Future<Response> registerUser(DtosRegisterRequest registerRequest) async {
    try {
      Response registerResponse =
          await AuthApi().authRegisterPostWithHttpInfo(registerRequest);
      if (kDebugMode) {
        print('User registered successfully: ${registerResponse.toString()}');
        print('Response body: ${registerResponse.body}');
      }
      return registerResponse;
    } catch (e) {
      if (kDebugMode) {
        print('Error in registerUser: $e');
      }
      rethrow;
    }
  }

}
