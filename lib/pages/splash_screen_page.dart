import 'dart:async';

import 'package:flutter/material.dart';

import 'main_navigation_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  int _durasiDetik = 10;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _mulaiHitungMundur();
  }

  void _mulaiHitungMundur() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_durasiDetik > 1) {
        setState(() {
          _durasiDetik--;
        });
      } else {
        _timer?.cancel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const MainNavigationPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFF2D55),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.point_of_sale_rounded,
                size: 72,
                color: Color(0xFFFF2D55),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'SmartKasir',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Aplikasi Kasir Point of Sale Digital',
              style: TextStyle(fontSize: 13, color: Colors.white70),
            ),
            const SizedBox(height: 36),
            const SizedBox(
              width: 28,
              height: 28,
              child: CircularProgressIndicator(
                color: Colors.amber,
                strokeWidth: 3,
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Menyiapkan sistem SmartKasir ($_durasiDetik detik)...',
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
