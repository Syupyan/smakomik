import 'package:flutter/material.dart';
import 'package:smaperpus/themes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';

final Uri _urlinsta = Uri.parse('https://instagram.com/snjakita');
final Uri _urlgit = Uri.parse('https://github.com/syupyan');
final Uri _urlmail = Uri.parse('mailto:paman.muhammad@gmail.com');

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key});

  @override
  Widget build(BuildContext context) {
    Widget header() {
      return Container(
        margin: EdgeInsets.only(top: 40),
        child: Container(
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Row(
              children: [
                Expanded(
                  // Menggunakan Expanded agar teks berada di tengah
                  child: Center(
                    child: Text(
                      'Informasi',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color:
                            greenColor, // Menggunakan greenColor dari tema yang diimpor
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget infoDescription() {
      return Container(
        height: 60,
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 12,
        ),
        decoration: BoxDecoration(
          color: greyColorInfo,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Tambahkan ini
          children: [
            ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true, // Tambahkan shrinkWrap: true
              children: [
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      _launchUrlInsta(); // Panggil fungsi _launchUrl saat tombol ditekan
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.transparent, // atau Colors.transparent
                      elevation: 0,
                    ),
                    child: Column(
                      children: [
                        Icon(
                          FontAwesomeIcons.instagram,
                          size: 20,
                          color: blackColor2,
                        ),
                        SizedBox(
                          height: 2,
                        ),
                        Text(
                          'Instagram',
                          style: semiBoldText12.copyWith(
                            color: blackColor2,
                            fontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            VerticalDivider(
              color: dividerColor,
              thickness: 1,
            ),
            ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true, // Tambahkan shrinkWrap: true
              children: [
                ElevatedButton(
                  onPressed: () {
                    _launchUrlGit(); // Panggil fungsi _launchUrl saat tombol ditekan
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.transparent, // atau Colors.transparent
                    elevation: 0,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.github,
                        size: 20,
                        color: blackColor2,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Github',
                        style: semiBoldText12.copyWith(
                          color: blackColor2,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            VerticalDivider(
              color: dividerColor,
              thickness: 1,
            ),
            ListView(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true, // Tambahkan shrinkWrap: true
              children: [
                ElevatedButton(
                  onPressed: () {
                    _launchUrlMail(); // Panggil fungsi _launchUrl saat tombol ditekan
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Colors.transparent, // atau Colors.transparent
                    elevation: 0,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.envelope,
                        size: 20,
                        color: blackColor2,
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Gmail',
                        style: semiBoldText12.copyWith(
                          color: blackColor2,
                          fontSize: 8,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget infoupdate() {
      return Container(
        margin: EdgeInsets.only(top: 20),
        width: double.infinity,
        // Menggunakan Stack untuk menempatkan dua container di atas satu sama lain
        child: Stack(
          children: [
            // Container untuk pojok kanan
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: 30, // Lebar container untuk pojok kanan
                height: 30, // Tinggi container untuk pojok kanan
                decoration: BoxDecoration(
                  color: Colors.red, // Warna container untuk pojok kanan
                  borderRadius: BorderRadius.only(
                    topLeft:
                        Radius.circular(10), // Melengkungkan pojok kiri atas
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: 30, // Lebar container untuk pojok kanan
                height: 30, // Tinggi container untuk pojok kanan
                decoration: BoxDecoration(
                  color: Colors.red, // Warna container untuk pojok kanan
                  borderRadius: BorderRadius.only(
                    topLeft:
                        Radius.circular(10), // Melengkungkan pojok kiri atas
                  ),
                ),
              ),
            ),
            // Container untuk teks
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(9),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.8),
                    spreadRadius: 0.5,
                    blurRadius: 100,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: AutoSizeText(
                "Di informasikan, bahwasanya pada tanggal 30 november aplikasi ini akan mengalami maintenance dengan segera akan menjadi sebuah apakah sayang",
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                maxLines: 100, // Batasi teks menjadi 100 baris
                minFontSize: 12.0, // Ukuran minimum font
                overflow: TextOverflow
                    .ellipsis, // Penanganan overflow dengan ellipsis
                textAlign: TextAlign.justify,
              ),
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
                        '',
                        style: semiBoldText20.copyWith(color: blackColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Hai,',
                        style: mediumText14.copyWith(color: greyColor),
                      )
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 30,
            ),
            Text(
              'Semoga teman-teman disini dapat menikmati komik yang tersedia di aplikasi ini. Mungkin jika teman-teman menemukan bug atau ada masalah pada aplikasi ini, silahkan hubungi saya :), dan saya sangat terbuka dengan saran-saran yang diberikan teman-teman.',
              style: regularText12.copyWith(color: greyColor),
              textAlign: TextAlign.justify, // Teks menjadi rata kiri-kanan
            ),
            infoDescription(),
            SizedBox(
              height: 12,
            ),
            infoupdate()
          ],
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            header(),
            SizedBox(
              height: 50,
            ),
            description(),
          ],
        ),
      ),
    );
  }
}

Future<void> _launchUrlInsta() async {
  if (!await launchUrl(_urlinsta)) {
    throw Exception('Could not launch $_urlinsta');
  }
}

Future<void> _launchUrlGit() async {
  if (!await launchUrl(_urlgit)) {
    throw Exception('Could not launch $_urlgit');
  }
}

Future<void> _launchUrlMail() async {
  if (!await launchUrl(_urlmail)) {
    throw Exception('Could not launch $_urlmail');
  }
}
