import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smaperpus/providers/comic_provider.dart'; // Import ComicProvider
import 'package:smaperpus/screens/info/info_page.dart';
import 'package:smaperpus/screens/home/home_page.dart';
import 'package:smaperpus/screens/book/book_page.dart';
import 'package:smaperpus/screens/user/user_page.dart';
import 'package:smaperpus/themes.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  late int _selectedIndex;
  late ComicProvider _comicProvider;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _comicProvider = Provider.of<ComicProvider>(context, listen: false); // Initialize ComicProvider
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _selectedIndex,
            children: [
              HomePage(),
              BookPage(),
              InfoPage(),
              UserPage(),
            ],
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: BottomNavigationBar(
                backgroundColor: Colors.transparent,
                selectedItemColor: greenColor,
                unselectedItemColor: greyColor,
                currentIndex: _selectedIndex,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home,
                      size: 24,
                    ),
                    label: 'Utama',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.book,
                      size: 24,
                    ),
                    label: 'Komik',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.info_outline,
                      size: 25,
                    ),
                    label: 'Info',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.account_circle_rounded,
                      size: 25,
                    ),
                    label: 'Pengguna',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
