import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../models/User.dart';
class AuthService{
  final String baseUrl = 'https://example.com/api'; //I m using it as a mock 
  final _Storage=const FlutterSecureStorage();
  
  
//here we are storing token in secure way .

Future<void>StoreToken(String token)async{
  await _Storage.write(key: 'auth_token', value: token);
}

Future<String?>getToken()async{
  return await _Storage.read(key: 'auth_token');
}
Future<void>ClearToken()async{
  await _Storage.delete(key: 'auth_token');
}

Future<User>login(String email,String password)async{
  final response=await http.post(
    Uri.parse('$baseUrl/login'),
    body: jsonEncode({'email': email, 'password': password}),
    headers: {'Content-Type': 'application/json'},

  );
  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    await StoreToken(data['token']);
    return User(id: data['id'], email: data['email']);
  } else {
    throw Exception('Invalid email or password');
  }
}
  Future<User> register(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      body: jsonEncode({'email': email, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      await StoreToken(data['token']);
      return User(id: data['id'], email: data['email']);
    } else {
      throw Exception('Registration failed');
    }
  }
  
  Future<void>logout()async{
  final token=await getToken();
  final response=await http.post(
    Uri.parse('$baseUrl/logout'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 200) {
    await ClearToken();
  } else {
    throw Exception('Logout failed');
  }
  }
}