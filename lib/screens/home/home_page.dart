import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smaperpus/screens/home/components/carousel_book.dart';
import 'package:smaperpus/screens/home/components/recent_book.dart';
import 'package:smaperpus/screens/home/components/trend_book.dart';
import 'package:smaperpus/themes.dart';
import 'package:smaperpus/models/models.dart';
import 'package:smaperpus/service/service_api.dart';
import 'package:smaperpus/service/service_verify.dart';

class HomePage extends StatefulWidget {
  static const nameRoute = '/homePage';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Comic>? _comicBookspop;
  late String _token;

  @override
  void initState() {
    super.initState();
    _verifyAndFetchComicBookspop();
  }

  Future<void> _verifyAndFetchComicBookspop() async {
      _token = await VerifyService.verifyAndFetchToken();
      final comicBooks = await ApiService.fetchComicspop(_token);
      setState(() {
        _comicBookspop = comicBooks;
      });
  }

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/images/profile-pic.jpg'),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hai yan,',
                  style: semiBoldText16,
                  textAlign: TextAlign.left,
                ),
                Text(
                  'Selamat Datang',
                  style: regularText14.copyWith(color: greyColor),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Spacer(),
            Icon(
              FontAwesomeIcons.dragon,
              size: 20,
              color: greyColor,
            ),
          ],
        ),
      );
    }

    Widget recentBooks(List<Map<String, String>> books) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: books.map((book) {
            return Padding(
              padding: EdgeInsets.only(right: 20),
              child: RecentBook(
                image: book['image'] ?? '',
                title: book['title'] ?? '',
                genre: book['genre'] ?? '',
                // percent: book['percent'] ?? '0.0',
              ),
            );
          }).toList(),
        ),
      );
    }

    Widget trendBooks(List<Comic> books) {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: books.map((comic) {
            return Padding(
              padding: EdgeInsets.only(right: 20),
              child: TrendBook(
                id: comic.id,
                image: comic.image,
                title: comic.name,
                genre: comic.genre,
                // percent: book['percent'] ?? '0.0',
              ),
            );
          }).toList(),
        ),
      );
    }

    return Scaffold(
      // backgroundColor: backgroundColor,
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
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
                  children: [
                    header(),
                  ],
                ),
              ),
              // pemisah
              Container(
                padding: EdgeInsets.symmetric(vertical: 2),
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
                    SliderP(),
                    SizedBox(height: 23),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Komik Favoritmu',
                        style: semiBoldText16.copyWith(color: whiteColor),
                      ),
                    ),
                    SizedBox(height: 5),
                    recentBooks([
                      {
                        'image': 'assets/images/recentbook_110.jpg',
                        'title': 'Ponyo',
                        'genre': 'adventure, comedy, drama',
                      },
                      {
                        'image': 'assets/images/recentbook_111.jpg',
                        'title': 'Grave of The Fireflies',
                        'genre': 'Drama, War',
                      },
                      // Add more books as needed
                    ]),
                  ],
                ),
              ),
              // pemisah
              Container(
                padding: EdgeInsets.symmetric(vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 22, 19, 19).withOpacity(0.5),
                      spreadRadius: 0.5,
                      blurRadius: 20,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Text(
                        'Komik Populer',
                        style: semiBoldText16.copyWith(color: whiteColor),
                      ),
                    ),
                    SizedBox(height: 5),
                    _comicBookspop != null
                        ? trendBooks(_comicBookspop!)
                        : Container(), // Show loading indicator if data is still loading
                    SizedBox(height: 19),
                  ],
                ),
              ),
              SizedBox(height: 80),
            ],
          )
        ],
      ),
    );
  }
}
