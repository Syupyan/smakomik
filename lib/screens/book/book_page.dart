import 'package:flutter/material.dart';
import 'package:smaperpus/screens/book/components/all_book.dart';
import 'package:smaperpus/themes.dart';
import 'package:smaperpus/models/models.dart';
import 'package:smaperpus/service/service_api.dart';
import 'package:smaperpus/service/service_verify.dart';

class BookPage extends StatefulWidget {
  const BookPage({Key? key}) : super(key: key);

  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  List<String> _categories = [
    'Semua',
    'Horror',
    'Adventure',
    'Romantic',
    'Fighter',
  ];

  List<Comic>? _comicBooks;
  List<Comic>? _originalComicBooks; // Menyimpan daftar komik asli
  late String _token;

  @override
  void initState() {
    super.initState();
    _verifyAndFetchComicBooks();
  }

  int _isSelected = 0;
  int _currentPage = 1;
  int _perPage = 8; // Jumlah item per halaman

  Future<void> _verifyAndFetchComicBooks() async {
      _token = await VerifyService.verifyAndFetchToken();
      final comicBooks = await ApiService.fetchComics(_token);
      setState(() {
        _comicBooks = comicBooks;
        _originalComicBooks = List.from(comicBooks); // Simpan daftar komik asli
      });
  }

  Future<void> _refreshComicBooks() async {
    await _verifyAndFetchComicBooks();
  }

  void _search(String query) {
    setState(() {
      _comicBooks = _originalComicBooks!
          .where((comic) =>
              comic.name.toLowerCase().contains(query.toLowerCase()) ||
              comic.genre.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _resetSearch() {
    setState(() {
      _comicBooks = List.from(_originalComicBooks!);
    });
  }

  void _filterByCategory(String category) {
    setState(() {
      if (category == 'Semua') {
        _comicBooks = List.from(_originalComicBooks!);
      } else {
        _comicBooks = _originalComicBooks!
            .where(
                (comic) => comic.genre.toLowerCase() == category.toLowerCase())
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget searchField() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: TextField(
          onChanged: (value) {
            if (value.isNotEmpty) {
              _search(value);
            } else {
              _resetSearch();
            }
          },
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: mediumText12.copyWith(color: greyColor),
            filled: true,
            fillColor: Colors.transparent,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
              borderRadius: BorderRadius.circular(100),
            ),
            isCollapsed: true,
            contentPadding: EdgeInsets.all(18),
            suffixIcon: Icon(
              Icons.search_rounded,
              color: whiteColor,
            ),
          ),
        ),
      );
    }

    Widget categories(int index) {
      final category = _categories[index];
      return InkWell(
        onTap: () {
          setState(() {
            _isSelected = index;
            _filterByCategory(category);
          });
        },
        child: Container(
          margin: EdgeInsets.only(top: 20, right: 12),
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          decoration: BoxDecoration(
              color: _isSelected == index ? greenColor : Colors.transparent,
              borderRadius: BorderRadius.circular(6)),
          child: Text(
            category,
            style: semiBoldText14.copyWith(
                color: _isSelected == index ? whiteColor : greenColor),
          ),
        ),
      );
    }

    Widget listCategories() {
      return SingleChildScrollView(
        padding: EdgeInsets.only(left: 30),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _categories
              .asMap()
              .entries
              .map((MapEntry map) => categories(map.key))
              .toList(),
        ),
      );
    }

    Widget buildItems() {
      if (_comicBooks == null) return Container();

      final startIndex = (_currentPage - 1) * _perPage;
      final endIndex = startIndex + _perPage;
      final itemsToShow = _comicBooks!.sublist(
        startIndex,
        endIndex < _comicBooks!.length ? endIndex : _comicBooks!.length,
      );

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: itemsToShow.map((comicBook) {
          return AllBook(
            id: comicBook.id,
            image: comicBook.image,
            title: comicBook.name,
            genre: comicBook.genre,
          );
        }).toList(),
      );
    }

    Widget paginationButtons() {
      final int totalPages =
          _comicBooks != null ? (_comicBooks!.length / _perPage).ceil() : 0;

      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: _currentPage > 1
                ? () {
                    setState(() {
                      _currentPage--;
                    });
                  }
                : null,
            icon: Icon(Icons.arrow_back),
          ),
          if (_currentPage > 2)
            TextButton(
              onPressed: () {
                setState(() {
                  _currentPage = 1;
                });
              },
              child: Text('1'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                    _currentPage == 1 ? Colors.blue : Colors.black),
              ),
            ),
          for (int page = _currentPage;
              page <= _currentPage + 2 && page <= totalPages;
              page++)
            TextButton(
              onPressed: () {
                setState(() {
                  _currentPage = page;
                });
              },
              child: Text('$page'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                    _currentPage == page ? Colors.blue : Colors.black),
              ),
            ),
          if (_currentPage < totalPages - 2)
            TextButton(
              onPressed: () {
                setState(() {
                  _currentPage = totalPages;
                });
              },
              child: Text('$totalPages'),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(
                    _currentPage == totalPages ? Colors.blue : Colors.black),
              ),
            ),
          IconButton(
            onPressed: _currentPage < totalPages
                ? () {
                    setState(() {
                      _currentPage++;
                    });
                  }
                : null,
            icon: Icon(Icons.arrow_forward),
          ),
        ],
      );
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshComicBooks,
        child: ListView(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 30),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(75),
                      bottomRight: Radius.circular(75),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 0.5,
                        blurRadius: 100,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      searchField(),
                      SizedBox(height: 23),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Text(
                          'Komik',
                          style: semiBoldText16.copyWith(color: whiteColor),
                        ),
                      ),
                      listCategories(),
                      SizedBox(height: 2),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: buildItems(),
                      ),
                      paginationButtons(),
                    ],
                  ),
                ),
                SizedBox(height: 100),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
