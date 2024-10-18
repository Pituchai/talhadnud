import 'package:dio/dio.dart';
import 'package:talhadnad/api_client/lib/api.dart';

class ApiService {
  static final Dio _dio = Dio(); // Dio client
  static final ApiClient _apiClient = ApiClient(); // Pass Dio instance

  static void setAuthToken(String token) {
    _dio.options.headers['Authorization'] =
        'Bearer $token'; // Set authorization header
  }

  static UsersApi get usersApi => UsersApi(_apiClient);
}
