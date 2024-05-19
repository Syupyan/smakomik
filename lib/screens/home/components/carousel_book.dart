import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:smaperpus/models/models.dart';
import 'package:smaperpus/service/service_api.dart';
import 'package:smaperpus/service/service_verify.dart';

class SliderP extends StatefulWidget {
  SliderP({Key? key}) : super(key: key);

  @override
  State<SliderP> createState() => _SliderPState();
}

class _SliderPState extends State<SliderP> {
  int activeIndex = 0;
  final controller = CarouselController();
  List<Comic>? _comicBooksnew;
  late String _token;

  @override
  void initState() {
    super.initState();
    _verifyAndFetchComicBooksnew();
  }

  Future<void> _verifyAndFetchComicBooksnew() async {
    _token = await VerifyService.verifyAndFetchToken();
    final comicBooksnew = await ApiService.fetchComicsnew(_token);
    setState(() {
      _comicBooksnew = comicBooksnew;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
          carouselController: controller,
          itemCount: _comicBooksnew?.length ?? 0,
          itemBuilder: (context, index, realIndex) {
            final comic = _comicBooksnew![index];
            return buildImageWithText(comic.image, comic.name);
          },
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            enableInfiniteScroll: false,
            autoPlayAnimationDuration: Duration(seconds: 1),
            enlargeCenterPage: true,
            onPageChanged: (index, reason) =>
                setState(() => activeIndex = index),
          ),
        ),
        SizedBox(height: 12),
        buildIndicator(),
      ],
    );
  }

  Widget buildImageWithText(String urlImage, String slideText) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              'https://smakomik-service-production.up.railway.app/assets/comic-image/comic-cover/$urlImage', // Menggunakan network image
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200.0,
            ),
          ),
          Positioned(
            top: 10.0,
            right: 10.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                'New',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 10.0,
            left: 10.0,
            right: 10.0,
            child: Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(
                slideText,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        onDotClicked: animateToSlide,
        effect: ExpandingDotsEffect(
          dotWidth: 15,
          dotHeight: 8,
          activeDotColor: Colors.blue,
        ),
        activeIndex: activeIndex,
        count: _comicBooksnew?.length ?? 0,
      );

  void animateToSlide(int index) => controller.animateToPage(index);
}
