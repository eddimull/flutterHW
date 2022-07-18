import 'dart:convert';
import 'dart:io';

import 'package:hello_world/models/Category.dart';
import 'package:http/http.dart' as http;

class ApiService {
  ApiService();

  final String baseUrl = 'http://localhost/api/';

  Future<List<Category>> fetchCategories() async {
    http.Response response = await http.get(Uri.parse('${baseUrl}categories'));

    List categories = jsonDecode(response.body);

    return categories.map((category) => Category.fromJson(category)).toList();
  }

  Future<Category> updateCategory(Category category) async {
    String uri = '${baseUrl}categories/${category.id}';

    http.Response response = await http.put(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({'name': category.name}));

    if (response.statusCode != 200) {
      throw Exception('Error updating. Code: ${response.statusCode}');
    }

    return Category.fromJson(jsonDecode(response.body));
  }

  Future<Category> addCategory(String name) async {
    String uri = '${baseUrl}categories';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({'name': name}));

    if (response.statusCode != 201) {
      throw Exception('Error Creating. Code: ${response.statusCode}');
    }

    return Category.fromJson(jsonDecode(response.body));
  }

  Future<void> deleteCategory(id) async {
    String uri = '${baseUrl}categories/$id';

    http.Response response = await http.delete(
      Uri.parse(uri),
      headers: {
        HttpHeaders.acceptHeader: 'application/json',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Error Deleting. Code: ${response.statusCode}');
    }
  }

  Future<String> register(String name, String email, String password, String passwordConfirm, String deviceName) async {
    String uri = '${baseUrl}auth/register';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirm,
          'device_name': deviceName
        }));

    if (response.statusCode == 422) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> errors = body['errors'];
      String errorMessage = '';

      errors.forEach((key, value) {
        errorMessage += '$key: $value\n';
      });
      throw Exception(errorMessage);
    }

    return response.body;
  }

    Future<String> login(String email, String password, String deviceName) async {
    String uri = '${baseUrl}auth/login';

    http.Response response = await http.post(Uri.parse(uri),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.acceptHeader: 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'device_name': deviceName
        }));

    if (response.statusCode == 422) {
      Map<String, dynamic> body = jsonDecode(response.body);
      Map<String, dynamic> errors = body['errors'];
      String errorMessage = '';

      errors.forEach((key, value) {
        errorMessage += '$key: $value\n';
      });
      throw Exception(errorMessage);
    }

    return response.body;
  }
}
