import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserService {
  Future<List<UserModel>> fetchUsers({int page = 1, int perPage = 6}) async {
    final url = Uri.parse('https://reqres.in/api/users?page=$page&per_page=$perPage');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List<dynamic> data = body['data'];
      return data.map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}