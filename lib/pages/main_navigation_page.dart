import 'package:flutter/material.dart';

import 'dashboard_page.dart';
import 'kasir_page.dart';
import 'riwayat_page.dart';
import 'profil_toko_page.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const DashboardPage(),
    const KasirPage(),
    const RiwayatPage(),
    const ProfilTokoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFFFF2D55),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Kasir',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Toko'),
        ],
      ),
    );
  }
}
