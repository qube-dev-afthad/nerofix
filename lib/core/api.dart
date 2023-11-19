import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:nerofix/utils/app_essentials.dart';

class ApiClient {
  final String baseUrl;

  ApiClient(this.baseUrl);

  Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  Future<dynamic> post(String endpoint, Map<dynamic, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl/$endpoint'),
      body: json.encode(data),
      // headers: {'Content-Type': 'application/json'},
    );
    // ignore: prefer_interpolation_to_compose_strings, unnecessary_brace_in_string_interps
    AppEssential.errorLog("URL:${baseUrl}/$endpoint}" + response.body);
    return _handleResponse(response);
  }

  Future<dynamic> postWithFormData(
      String endpoint, Map<dynamic, dynamic> data) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$baseUrl/$endpoint'));

    // Convert data to FormData
    data.forEach((key, value) {
      if (value is String) {
        request.fields[key.toString()] = value.toString();
      } else if (value is List<int>) {
        request.files.add(http.MultipartFile.fromBytes(
          key.toString(),
          value,
          filename: 'file.jpg', // Adjust filename as per your requirement
          contentType: MediaType('image', 'jpeg'), // Adjust content type
        ));
      }
      // Add more conditions as needed for different data types
    });

    // Send the request
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    // Logging
    response.statusCode == 200
        ? AppEssential.successLog(
            "URL:$baseUrl/$endpoint ${response.statusCode}\nREQUEST: ${request.fields} \n\nRESP:${response.body}")
        : AppEssential.errorLog(
            "URL:$baseUrl/$endpoint ${response.statusCode}\nREQUEST :${request.fields} \n\nRESP:${response.body}");

    return _handleResponse(response);
  }

  dynamic _handleResponse(http.Response response) {
    if (response.statusCode == 200) {
      return { "data": json.decode(response.body), "status": true};
    } else {
      return {"status":false};
    }
  }
}
