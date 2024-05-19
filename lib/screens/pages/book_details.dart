import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smaperpus/service/service_verify.dart';
import 'package:smaperpus/themes.dart';
import 'package:smaperpus/models/models.dart';
import 'package:smaperpus/service/service_api.dart';
// import 'package:smaperpus/service/service_verify.dart';
import 'package:smaperpus/screens/pages/book_images.dart';

class BookDetail extends StatelessWidget {
  static const nameRoute = '/bookDetails';
  const BookDetail({super.key});

  void _showSbimages(BuildContext context, List<Sbimages> sbimages,
      List<Subbutton> subbuttons) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SbimagesPage(sbimages: sbimages, subbuttons: subbuttons),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context)?.settings.arguments as Map;
    final String status = data['detail'] != null ? data['detail'].status : '';
    final String ddescrip =
        data['detail'] != null ? data['detail'].description : '';

    Widget header() {
      return Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.9),
                ],
              ),
              image: DecorationImage(
                image: NetworkImage(
                  'https://smakomik-service-production.up.railway.app/assets/comic-image/comic-cover/${data['image']}',
                ),
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
            bottom: 169,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(100),
                          topRight: Radius.circular(100),
                          bottomLeft: Radius.circular(100),
                          bottomRight: Radius.circular(100),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 22, 19, 19)
                                .withOpacity(0.5),
                            spreadRadius: 0.5,
                            blurRadius:
                                20, // Mengurangi nilai blurRadius untuk membuatnya lebih halus
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.chevron_left_rounded,
                        size: 35,
                        color: whiteColor,
                      ),
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 22, 19, 19)
                                .withOpacity(0.5),
                            spreadRadius: 0.5,
                            blurRadius: 20,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      padding:
                          EdgeInsets.all(10), // Atur padding sesuai kebutuhan
                      child: Text(
                        'Detail Komik',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100),
                        topRight: Radius.circular(100),
                        bottomLeft: Radius.circular(100),
                        bottomRight: Radius.circular(100),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color:
                              Color.fromARGB(255, 22, 19, 19).withOpacity(0.5),
                          spreadRadius: 0.5,
                          blurRadius:
                              20, // Mengurangi nilai blurRadius untuk membuatnya lebih halus
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.all(10),
                    child: Icon(
                      FontAwesomeIcons.dragon,
                      size: 17,
                      color: whiteColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    Widget subButtonList(List<Subbutton> subbuttons) {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: subbuttons.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () async {
              showDialog(
                context: context,
                builder: (context) => Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );

              final String token = await VerifyService.verifyAndFetchToken();
              final List<Sbimages> sbimages = await ApiService.fetchSbimages(
                  token, subbuttons[index].idsub);
              Navigator.pop(context); // Tutup dialog loading
              _showSbimages(context, sbimages, data['subbuttons']);
            },
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            child: Container(
              height: 80,
              margin: EdgeInsets.only(top: index == 0 ? 20 : 10),
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
              decoration: BoxDecoration(
                color: greyColorInfo,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          subbuttons[index].name,
                          style: mediumText10.copyWith(color: dividerColor),
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          subbuttons[index].namesub,
                          style: semiBoldText12.copyWith(color: blackColor2),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          );
        },
      );
    }

    Widget chapter() {
      return Container(
        height: 80,
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
        decoration: BoxDecoration(
          color: greyColorInfo,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          mainAxisAlignment:
              MainAxisAlignment.start, // Menentukan posisi teks ke kiri
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start, // Menentukan posisi teks dalam Column
                children: [
                  Text(
                    'Ponoyo Chapter 59',
                    style: mediumText10.copyWith(color: dividerColor),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    'Kehancuran dunia pada siapa yang menduga ',
                    style: semiBoldText12.copyWith(color: blackColor2),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget description() {
      return Container(
        // margin: EdgeInsets.only(bottom: 20000),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
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
                        style: semiBoldText20.copyWith(color: whiteColor),
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
                  status,
                  style: mediumText14.copyWith(color: greenColor),
                )
              ],
            ),
            SizedBox(
              width: 30,
            ),
            Text(
              'Description',
              style: semiBoldText14.copyWith(color: whiteColor),
            ),
            SizedBox(
              height: 6,
            ),
            Text(
              ddescrip,
              style: regularText12.copyWith(color: greyColor),
            ),
            subButtonList(data['subbuttons']),
          ],
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(),
            // bookImage(),
            Container(
              // Tambahkan properti Container sesuai kebutuhan
              decoration: BoxDecoration(
                color: Colors.transparent, // Ganti dengan warna yang diinginkan
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 0.5,
                    blurRadius: 9999880,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: description(),
            ),
          ],
        ),
      ),
    );
  }
}
