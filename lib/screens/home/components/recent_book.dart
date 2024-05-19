import 'package:flutter/material.dart';
import 'package:smaperpus/screens/pages/book_details.dart';
import 'package:smaperpus/themes.dart';

class RecentBook extends StatelessWidget {
  const RecentBook({
    super.key,
    required this.image,
    required this.title,
    required this.genre,
  });

  final String image;
  final String title;
  final String genre;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        // border: Border.all(color: greyColor),
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: InkWell(
                            onTap: () {
              Navigator.pushNamed(context, BookDetail.nameRoute, arguments: {
                'image' : image,
                'title' : title,
                'genre' : genre,
              });
            },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                image,
                width: 90,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                // border: Border.all(color: greyColor),
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
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
                  Text(
                    title,
                    style: semiBoldText12.copyWith(color: whiteColor),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Genre:',
                    style:
                        semiBoldText12.copyWith(color: greyColor, fontSize: 10),
                  ),
                  Text(
                    genre,
                    style: mediumText12.copyWith(color: greyColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
