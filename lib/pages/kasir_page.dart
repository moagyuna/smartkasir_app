import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/produk.dart';

class KasirPage extends StatefulWidget {
  const KasirPage({super.key});

  @override
  State<KasirPage> createState() => _KasirPageState();
}

class _KasirPageState extends State<KasirPage> {
  final Map<Produk, int> _keranjang = {};

  String _formatRupiah(double angka) {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(angka);
  }

  double _hitungTotal() {
    double total = 0;
    _keranjang.forEach((produk, jumlah) {
      total += produk.harga * jumlah;
    });
    return total;
  }

  void _tambahKeKeranjang(Produk produk) {
    setState(() {
      int jumlahSekarang = _keranjang[produk] ?? 0;
      if (jumlahSekarang < produk.stok) {
        _keranjang[produk] = jumlahSekarang + 1;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Stok ${produk.nama} tidak mencukupi!')),
        );
      }
    });
  }

  void _kurangiDariKeranjang(Produk produk) {
    setState(() {
      int jumlahSekarang = _keranjang[produk] ?? 0;
      if (jumlahSekarang > 1) {
        _keranjang[produk] = jumlahSekarang - 1;
      } else {
        _keranjang.remove(produk);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kasir POS')),
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: daftarProdukDummy.length,
              itemBuilder: (context, index) {
                final produk = daftarProdukDummy[index];
                return Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.fastfood,
                      color: Color(0xFFFF2D55),
                    ),
                    title: Text(
                      produk.nama,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${_formatRupiah(produk.harga)} | Stok: ${produk.stok}',
                    ),
                    trailing: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF2D55),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => _tambahKeKeranjang(produk),
                      icon: const Icon(Icons.add_shopping_cart, size: 18),
                      label: const Text('Tambah'),
                    ),
                  ),
                );
              },
            ),
          ),
          const VerticalDivider(width: 1),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  color: Colors.grey[200],
                  child: const Text(
                    'Ringkasan Pesanan',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Expanded(
                  child: _keranjang.isEmpty
                      ? const Center(child: Text('Keranjang masih kosong'))
                      : ListView(
                          children: _keranjang.entries.map((entry) {
                            final produk = entry.key;
                            final jumlah = entry.value;
                            return ListTile(
                              title: Text(
                                produk.nama,
                                style: const TextStyle(fontSize: 14),
                              ),
                              subtitle: Text(
                                _formatRupiah(produk.harga * jumlah),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                      color: Colors.red,
                                    ),
                                    onPressed: () =>
                                        _kurangiDariKeranjang(produk),
                                  ),
                                  Text(
                                    '$jumlah',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.add_circle_outline,
                                      color: Colors.green,
                                    ),
                                    onPressed: () => _tambahKeKeranjang(produk),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 4,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Pembayaran:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            _formatRupiah(_hitungTotal()),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xFFFF2D55),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFF2D55),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          onPressed: _keranjang.isEmpty
                              ? null
                              : () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Transaksi Berhasil!'),
                                    ),
                                  );
                                  setState(() {
                                    _keranjang.clear();
                                  });
                                },
                          child: const Text('BAYAR SEKARANG'),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
