import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smaperpus/models/models.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class ApiService {
  static final storage = FlutterSecureStorage();

  static Future<List<Comic>> fetchComics(String token) async {
    final response = await http.get(
      Uri.parse(
          'https://smakomik-service-production.up.railway.app/api/comicbook/'),
      headers: {
        'Cookie': 'token=$token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Comic> comics = jsonResponse.map((data) {
        return Comic.fromJson({...data, 'id': data['id_comic'].toString()});
      }).toList();
      return comics;
    } else {
      throw Exception('Internet bermasalah atau Aplikasi sedang dalam perbaikan');
    }
  }

  static Future<Detail> fetchDetail(String token, String id) async {
    final response = await http.get(
      Uri.parse(
          'https://smakomik-service-production.up.railway.app/api/comicbook/detail/$id'),
      headers: {
        'Cookie': 'token=$token',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return Detail.fromJson(jsonResponse);
    } else {
            throw Exception('Internet bermasalah atau Aplikasi sedang dalam perbaikan');

    }
  }

  static Future<List<Subbutton>> fetchSubbuttons(
      String token, String id) async {
    final response = await http.get(
      Uri.parse(
          'https://smakomik-service-production.up.railway.app/api/comicbook/subbtns/$id'),
      headers: {
        'Cookie': 'token=$token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Subbutton> subbuttons = jsonResponse.map((data) {
        return Subbutton.fromJson(
            {...data, 'idsub': data['id_sub'].toString()});
      }).toList();
      return subbuttons;
    } else {
          throw Exception('Internet bermasalah atau Aplikasi sedang dalam perbaikan');

    }
  }

  static Future<List<Sbimages>> fetchSbimages(
      String token, String idsub) async {
    final response = await http.get(
      Uri.parse(
          'https://smakomik-service-production.up.railway.app/api/comicbook/subbtns/images/$idsub'),
      headers: {
        'Cookie': 'token=$token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((sbimagesJson) => Sbimages.fromJson(sbimagesJson))
          .toList();
    } else {
      throw Exception('Failed to load subbuttons');
    }
  }

  static Future<List<Comic>> fetchComicsnew(String token) async {
    final response = await http.get(
      Uri.parse(
          'https://smakomik-service-production.up.railway.app/api/comicbook/new'),
      headers: {
        'Cookie': 'token=$token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Comic> comics = jsonResponse.map((data) {
        return Comic.fromJson({...data, 'id': data['id_comic'].toString()});
      }).toList();
      return comics;
    } else {
            throw Exception('Internet bermasalah atau Aplikasi sedang dalam perbaikan');

    }
  }

  static Future<List<Comic>> fetchComicspop(String token) async {
    final response = await http.get(
      Uri.parse(
          'https://smakomik-service-production.up.railway.app/api/comicbook/populer'),
      headers: {
        'Cookie': 'token=$token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Comic> comics = jsonResponse.map((data) {
        return Comic.fromJson({...data, 'id': data['id_comic'].toString()});
      }).toList();
      return comics;
    } else {
            throw Exception('Internet bermasalah atau Aplikasi sedang dalam perbaikan');

    }
  }
}
