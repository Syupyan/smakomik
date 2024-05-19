// import 'package:flutter/material.dart';
// import 'package:smaperpus/screens/book/components/all_book.dart';
// import 'package:smaperpus/themes.dart';
// import 'package:smaperpus/models/models.dart';
// import 'package:smaperpus/service/service_api.dart';
// import 'package:smaperpus/service/service_verify.dart';

// class BookPage extends StatefulWidget {
//   const BookPage({Key? key}) : super(key: key);

//   @override
//   State<BookPage> createState() => _BookPageState();
// }

// class _BookPageState extends State<BookPage> {
//   List<String> _categories = [
//     'Semua',
//     'Action',
//     'Gore',
//     'Romantic',
//     'Drama',
//   ];

//   List<Comic>? _comicBooks;
//   late String _token;

//   @override
//   void initState() {
//     super.initState();
//     _verifyAndFetchComicBooks();
//   }

//   int _isSelected = 0;

//   Future<void> _verifyAndFetchComicBooks() async {
//     try {
//       _token = await VerifyService.getToken();
//       if (_token.isEmpty) {
//         print('Token is empty');
//         return;
//       }
//       final comicBooks = await ApiService.fetchComics(_token);
//       setState(() {
//         _comicBooks = comicBooks;
//       });
//     } catch (error) {
//       print('Error occurred: $error');
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: Text('Error'),
//             content: Text('Failed to load comics. Please try again later.'),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop();
//                 },
//                 child: Text('OK'),
//               ),
//             ],
//           );
//         },
//       );
//     }
//   }

//   Future<void> _refreshComicBooks() async {
//     await _verifyAndFetchComicBooks();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Widget searchField() {
//       return Container(
//         margin: EdgeInsets.symmetric(horizontal: 30),
//         child: TextField(
//           decoration: InputDecoration(
//             hintText: 'Search',
//             hintStyle: mediumText12.copyWith(color: greyColor),
//             filled: true,
//             fillColor: Colors
//                 .transparent, // Menyesuaikan warna latar belakang dengan ikon
//             border: OutlineInputBorder(
//               borderSide: BorderSide(color: Colors.grey),
//               borderRadius: BorderRadius.circular(100),
//             ),
//             isCollapsed: true,
//             contentPadding: EdgeInsets.all(18),
//             suffixIcon: IconButton(
//               // Menggunakan IconButton sebagai suffixIcon
//               onPressed: () {},
//               icon: Icon(
//                 Icons.search_rounded,
//                 color: whiteColor,
//               ),
//             ),
//           ),
//         ),
//       );
//     }

//     Widget categories(int index) {
//       return InkWell(
//         onTap: () {
//           setState(() {
//             _isSelected = index;
//           });
//         },
//         child: Container(
//           margin: EdgeInsets.only(top: 20, right: 12),
//           padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//           decoration: BoxDecoration(
//               color: _isSelected == index ? greenColor : Colors.transparent,
//               borderRadius: BorderRadius.circular(6)),
//           child: Text(
//             _categories[index],
//             style: semiBoldText14.copyWith(
//                 color: _isSelected == index ? whiteColor : greenColor),
//           ),
//         ),
//       );
//     }

//     Widget listCategories() {
//       return SingleChildScrollView(
//         padding: EdgeInsets.only(left: 30),
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: _categories
//               .asMap()
//               .entries
//               .map((MapEntry map) => categories(map.key))
//               .toList(),
//         ),
//       );
//     }

//     return Scaffold(
//       body: RefreshIndicator(
//         onRefresh: _refreshComicBooks,
//         child: ListView(
//           children: [
//             Column(
//               children: [
//                 Container(
//                   padding: EdgeInsets.symmetric(vertical: 30),
//                   decoration: BoxDecoration(
//                     color: Colors.transparent,
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(75),
//                       bottomRight: Radius.circular(75),
//                     ),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.2),
//                         spreadRadius: 0.5,
//                         blurRadius: 100,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       searchField(),
//                       SizedBox(height: 23),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 30),
//                         child: Text(
//                           'Komik hei',
//                           style: semiBoldText16.copyWith(color: whiteColor),
//                         ),
//                       ),
//                       listCategories(),
//                       SizedBox(height: 2),
//                       Padding(
//                         padding: const EdgeInsets.all(16.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: _comicBooks != null
//                               ? _comicBooks!.map((comicBook) {
//                                   return AllBook(
//                                     id: comicBook.id,
//                                     image: comicBook.image,
//                                     title: comicBook.name,
//                                     genre: comicBook.genre,
//                                   );
//                                 }).toList()
//                               : [],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 100),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
