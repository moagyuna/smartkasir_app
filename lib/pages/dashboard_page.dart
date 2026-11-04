import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/produk.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _kategoriTerpilih = 0;
  final List<String> _kategoriList = ['Semua', 'Makanan', 'Minuman', 'Snack'];

  String _formatRupiah(double nominal) {
    final formatCurrency = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatCurrency.format(nominal);
  }

  Widget _buildBadgeStok(int stok) {
    Color warnaLatar;
    Color warnaTeks;
    String label;

    if (stok == 0) {
      warnaLatar = Colors.grey.shade200;
      warnaTeks = Colors.grey.shade700;
      label = 'Habis';
    } else if (stok <= 5) {
      warnaLatar = Colors.amber.shade100;
      warnaTeks = Colors.amber.shade900;
      label = 'Sisa $stok';
    } else {
      warnaLatar = const Color(0xFFFFEAEA);
      warnaTeks = const Color(0xFFFF2D55);
      label = 'Stok $stok';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: warnaLatar,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: warnaTeks,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final listTampil = _kategoriTerpilih == 0
        ? daftarProdukDummy
        : daftarProdukDummy
              .where((p) => p.kategori == _kategoriList[_kategoriTerpilih])
              .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.point_of_sale, color: Colors.white, size: 24),
            SizedBox(width: 8),
            Text(
              'SmartKasir',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Notifikasi Penjualan',
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF2D55), Color(0xFFFF6080)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x4DFF2D55),
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Penjualan Hari Ini',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatRupiah(845000),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.25),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.receipt_long, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '34 Transaksi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 42,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: _kategoriList.length,
              itemBuilder: (context, index) {
                final isSelected = _kategoriTerpilih == index;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Text(_kategoriList[index]),
                    selected: isSelected,
                    selectedColor: const Color(0xFFFF2D55),
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: isSelected
                          ? FontWeight.bold
                          : FontWeight.normal,
                      fontSize: 12,
                    ),
                    onSelected: (val) {
                      setState(() {
                        _kategoriTerpilih = index;
                      });
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: listTampil.isEmpty
                ? const Center(
                    child: Text('Tidak ada produk pada kategori ini'),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.90,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                        ),
                    itemCount: listTampil.length,
                    itemBuilder: (context, index) {
                      final produk = listTampil[index];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 125,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(10),
                                    ),
                                    child: Image.network(
                                      produk.gambarUrl,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: 125,
                                      errorBuilder: (ctx, err, stack) =>
                                          Container(
                                            height: 125,
                                            color: Colors.grey.shade200,
                                            child: const Icon(
                                              Icons.fastfood,
                                              size: 40,
                                              color: Colors.grey,
                                            ),
                                          ),
                                    ),
                                  ),
                                  if (produk.diskonPersen > 0)
                                    Positioned(
                                      top: 8,
                                      left: 8,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFFF2D55),
                                          borderRadius: BorderRadius.circular(
                                            4,
                                          ),
                                        ),
                                        child: Text(
                                          'PROMO ${produk.diskonPersen}%',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    produk.nama,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  _buildBadgeStok(produk.stok),
                                  const SizedBox(height: 3),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _formatRupiah(produk.harga),
                                        style: const TextStyle(
                                          color: Color(0xFFFF2D55),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: produk.stok == 0 ? null : () {},
                                        borderRadius: BorderRadius.circular(15),
                                        child: CircleAvatar(
                                          radius: 14,
                                          backgroundColor: produk.stok == 0
                                              ? Colors.grey.shade300
                                              : const Color(0xFFFF2D55),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
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
