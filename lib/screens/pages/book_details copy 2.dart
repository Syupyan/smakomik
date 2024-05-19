import 'package:flutter/material.dart';
import 'package:smaperpus/themes.dart';

class BookDetail extends StatelessWidget {
  static const nameRoute = '/bookDetails';
  const BookDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context)?.settings.arguments as Map;
    Widget header() {
      return Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/profile-pic.jpg'),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16.0),
                bottomRight: Radius.circular(16.0),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 250,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              height: MediaQuery.of(context).size.height * 0.5,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.chevron_left_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Book Details',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Icon(
                    Icons.share_outlined,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget bookImage() {
      return Container(
        height: 267,
        width: 175,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(data['image']),
          ),
        ),
      );
    }

    buttonRead() {
      return Container(
        height: 50,
        width: double.infinity,
        margin: EdgeInsets.only(top: 30),
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: greenColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: Text(
            'read now',
            style: semiBoldText20.copyWith(color: whiteColor),
          ),
        ),
      );
    }

    Widget infoDescription() {
      return Container(
        height: 60,
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: greyColorInfo,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  'Rating',
                  style: mediumText10.copyWith(color: dividerColor),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  '4.8',
                  style: semiBoldText12.copyWith(color: blackColor2),
                ),
              ],
            ),
            VerticalDivider(
              color: dividerColor,
              thickness: 1,
            ),
            Column(
              children: [
                Text(
                  'Rating',
                  style: mediumText10.copyWith(color: dividerColor),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  '4.8',
                  style: semiBoldText12.copyWith(color: blackColor2),
                ),
              ],
            ),
            VerticalDivider(
              color: dividerColor,
              thickness: 1,
            ),
            Column(
              children: [
                Text(
                  'Rating',
                  style: mediumText10.copyWith(color: dividerColor),
                ),
                SizedBox(
                  height: 2,
                ),
                Text(
                  '4.8',
                  style: semiBoldText12.copyWith(color: blackColor2),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget description() {
      return Container(
        margin: EdgeInsets.only(bottom: 20000),
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['title'],
                        style: semiBoldText20.copyWith(color: blackColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        data['genre'],
                        style: mediumText14.copyWith(color: greyColor),
                      )
                    ],
                  ),
                ),
                Text(
                  'Free Access',
                  style: mediumText14.copyWith(color: greenColor),
                )
              ],
            ),
            SizedBox(
              width: 30,
            ),
            Text(
              'Description',
              style: semiBoldText14.copyWith(color: blackColor2),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              'hahshashahhsahshasha shahsahshas hashahsahsh hashahshash hashahsah hsahsahsh ahshahsha',
              style: regularText12.copyWith(color: greyColor),
            ),
            infoDescription(),
            buttonRead(),
          ],
        ),
      );
    }

    return Scaffold(
      body: ListView(
        children: [
          header(),
          // bookImage(),
          description(),
        ],
      ),
    );
  }
}
