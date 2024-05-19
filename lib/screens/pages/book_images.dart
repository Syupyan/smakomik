import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:smaperpus/models/models.dart';

class SbimagesPage extends StatelessWidget {
  final List<Subbutton> subbuttons;
  final List<Sbimages> sbimages;
  final String baseUrl =
      'https://smakomik-service-production.up.railway.app/assets/comic-image/comic-chapter/';

  const SbimagesPage(
      {Key? key, required this.sbimages, required this.subbuttons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top +
                    20), // Padding atas untuk menurunkan header lebih jauh
            child: Header(
              onBackTap: () {
                Navigator.pop(context);
              },
              subbuttons: subbuttons, // Menambahkan subbuttons ke Header
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: sbimages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    baseUrl + sbimages[index].images,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) {
                        return child;
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Text('Failed to load image'),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  final VoidCallback onBackTap;
  final List<Subbutton> subbuttons; // Menambahkan subbuttons di sini

  const Header({Key? key, required this.onBackTap, required this.subbuttons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onBackTap,
            child: Icon(
              Icons.chevron_left_rounded,
              size: 30,
              color: Colors.white,
            ),
          ),
          Text(
            subbuttons.isNotEmpty ? subbuttons[0].namesub : 'No Namesub',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Icon(
            FontAwesomeIcons.dragon,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
