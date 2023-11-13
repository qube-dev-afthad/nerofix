import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;

  ApiClient(this.baseUrl);

  Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      body: json.encode(data),
      headers: {'Content-Type': 'application/json'},
    );
    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('API request failed with status ${response.statusCode}');
    }
  }
}

class MyApi {
  final ApiClient _apiClient;

  MyApi(this._apiClient);

  Future<dynamic> fetchData() {
    return _apiClient.get('your_endpoint');
  }

  Future<dynamic> postData(Map<String, dynamic> data) {
    return _apiClient.post('your_post_endpoint', data);
  }
}
