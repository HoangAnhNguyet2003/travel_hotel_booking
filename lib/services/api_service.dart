import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:travel_hotel_booking/models/User/User.dart';

class ApiService {
  final String baseUrl = 'http://127.0.0.1:5000/api/users';

  Future<Map<String, dynamic>?> signupUser(User user) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(user.toJson()),
      );

      if (response.statusCode == 201) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      return {'error': 'Connection error: $e'};
    }
  }

  Future<Map<String, dynamic>?> signinUser(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signin'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        return json.decode(response.body);
      }
    } catch (e) {
      return {'error': 'Connection error: $e'};
    }
  }
}