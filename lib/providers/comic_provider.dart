import 'package:flutter/material.dart';
import 'package:smaperpus/models/models.dart'; // atau lokasi model Comic
import 'package:smaperpus/service/service_api.dart'; // import ApiService

class ComicProvider extends ChangeNotifier {
  List<Comic> _comicBooks = []; // List untuk menyimpan data komik

  // Getter untuk mendapatkan data komik
  List<Comic> get comicBooks => _comicBooks;

  // Fungsi untuk memuat data komik dari API atau sumber lainnya
  Future<void> fetchComicBooks(String token) async {
    try {
      _comicBooks = await ApiService.fetchComics(token);
      notifyListeners(); // Panggil notifyListeners() untuk memberi tahu widget yang menggunakan provider ini bahwa status data telah berubah
    } catch (e) {
      print('Error fetching comic books: $e');
    }
  }
}
