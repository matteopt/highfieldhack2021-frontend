import 'dart:convert';
import 'package:http/http.dart' as http;

String _ip = '35.188.168.116';

Future<http.Response> registerUser(String username, String email, String password) {
  return http.post(
    Uri.http(_ip, 'main/register/'),
    body: <String, String>{
      'username': username,
      'email': email,
      'password': password,
    },
  );
}

Future<http.Response> loginUser(String username, String password) {
  return http.post(
    Uri.http(_ip, 'main/login/'),
    body: <String, String>{
      'username': username,
      'password': password,
    },
  );
}
