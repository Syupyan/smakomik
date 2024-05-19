import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

class VerifyService {
  // static Future<String?> getTokenFromStorage() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('token');
  // }

  static Future<String> verifyAndFetchToken() async {
    final username = 'kodeman';
    final password = 'mankode';

    try {

        final response = await http.post(
          Uri.parse('https://smakomik-service-production.up.railway.app/verify'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'user': username, 'pass': password}),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          final token = data['token'];

          // // Simpan token ke penyimpanan untuk penggunaan berikutnya
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // await prefs.setString('token', token);

          return token;
        } else {
          throw Exception('Failed to verify token');
        }
    } catch (error) {
      throw Exception('Failed to verify token: $error');
    }
  }
}
