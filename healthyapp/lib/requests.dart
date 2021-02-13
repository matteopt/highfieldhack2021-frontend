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

Future<http.Response> addFriend(String from, String to) {
  return http.post(
    Uri.http(_ip, 'main/add/'),
    body: <String, String>{
      'user1': from,
      'user2': to,
    },
  );
}

Future<http.Response> getFriendRequestsReceived(String username) {
  return http.get(
    Uri.http(_ip, 'main/friend_requests_received/' + username),
  );
}

Future<http.Response> getFriendRequestsSent(String username) {
  return http.get(
    Uri.http(_ip, 'main/friend_requests_sent/' + username),
  );
}

Future<http.Response> getLeaderBoards() {
  return http.get(
    Uri.http(_ip, 'main/leaderboards/'),
  );
}


