import 'package:flutter/material.dart';
import 'package:smaperpus/screens/bottom_nav_bar.dart';
import 'package:animated_glitch/animated_glitch.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:connectivity/connectivity.dart';

class SplashScreen extends StatefulWidget {
  static const nameRoute = '/';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _controller = AnimatedGlitchController(
    frequency: const Duration(milliseconds: 200),
    level: 1.2,
    distortionShift: const DistortionShift(count: 3),
  );

  bool _hasConnection = true;

  @override
  void initState() {
    super.initState();
    _checkInternetAndNavigate();
  }

  Future<void> _checkInternetAndNavigate() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    setState(() {
      _hasConnection = connectivityResult != ConnectivityResult.none;
    });
    if (_hasConnection) {
      _navigateToHomePage();
    }
  }

  void _navigateToHomePage() {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => BottomNavBar()),
      );
    });
  }

  void _reloadPage() {
    _checkInternetAndNavigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedGlitch(
            filters: [
              GlitchColorFilter(
                blendMode: BlendMode.color,
                color: Color.fromARGB(255, 22, 19, 19).withOpacity(0.5),
              )
            ],
            controller: _controller,
            child: Image.asset(
              'assets/images/splash.jpg',
              fit: BoxFit.fill,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.dragon,
                  color: Colors.white,
                  size: 120.0,
                ),
                Text(
                  'SMAKOMIK',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (!_hasConnection) ...[
                  SizedBox(height: 20),
                  Text(
                    'Tidak ada koneksi internet :)',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16.0,
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _reloadPage,
                    child: Text('Reload'),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
