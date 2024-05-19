import 'package:flutter/material.dart';
import 'package:smaperpus/screens/pages/book_details.dart';
import 'package:smaperpus/themes.dart';
import 'package:smaperpus/models/models.dart';
import 'package:smaperpus/service/service_api.dart';
import 'package:smaperpus/service/service_verify.dart';

class TrendBook extends StatelessWidget {
  const TrendBook({
    Key? key,
    required this.id,
    required this.image,
    required this.title,
    required this.genre,
  }) : super(key: key);

  final String id;
  final String image;
  final String title;
  final String genre;

  Future<Map<String, dynamic>> _fetchData(BuildContext context) async {
    try {
      final token = await VerifyService.verifyAndFetchToken();
      final Detail detail = await ApiService.fetchDetail(token, id);
      final List<Subbutton> subbuttons =
          await ApiService.fetchSubbuttons(token, id);
      return {'detail': detail, 'subbuttons': subbuttons};
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memuat data. Silakan coba lagi.'),
        ),
      );
      rethrow; // Re-throw error untuk menampilkan pesan kesalahan pada konsol
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: InkWell(
        onTap: () async {
          showDialog(
            context: context,
            builder: (context) => Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );

          final data = await _fetchData(context);
          Navigator.pop(context); // Tutup dialog loading
          Navigator.pushNamed(context, BookDetail.nameRoute, arguments: {
            'image': image,
            'title': title,
            'genre': genre,
            'detail': data['detail'],
            'subbuttons': data['subbuttons'],
          });
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                'https://smakomik-service-production.up.railway.app/assets/comic-image/comic-cover/$image',
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
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
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
