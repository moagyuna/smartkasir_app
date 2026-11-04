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
    final bool isLayarLebar = MediaQuery.of(context).size.width > 700;

    Widget daftarProdukWidget = ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: daftarProdukDummy.length,
      itemBuilder: (context, index) {
        final produk = daftarProdukDummy[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Icon(Icons.fastfood, color: Color(0xFFFF2D55), size: 30),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        produk.nama,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${_formatRupiah(produk.harga)} | Stok: ${produk.stok}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF2D55),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: produk.stok == 0
                      ? null
                      : () => _tambahKeKeranjang(produk),
                  child: const Text('Tambah', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
        );
      },
    );

    Widget areaKeranjangWidget = Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          color: Colors.grey[200],
          child: const Text(
            'Ringkasan Pesanan',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        Expanded(
          child: _keranjang.isEmpty
              ? const Center(
                  child: Text(
                    'Keranjang masih kosong',
                    style: TextStyle(fontSize: 12),
                  ),
                )
              : ListView(
                  children: _keranjang.entries.map((entry) {
                    final produk = entry.key;
                    final jumlah = entry.value;
                    return ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      title: Text(
                        produk.nama,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        _formatRupiah(produk.harga * jumlah),
                        style: const TextStyle(fontSize: 11),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              color: Colors.red,
                              size: 20,
                            ),
                            onPressed: () => _kurangiDariKeranjang(produk),
                          ),
                          Text(
                            '$jumlah',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(
                              Icons.add_circle_outline,
                              color: Colors.green,
                              size: 20,
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
          padding: const EdgeInsets.all(12),
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
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                  Text(
                    _formatRupiah(_hitungTotal()),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Color(0xFFFF2D55),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF2D55),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 10),
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
                  child: const Text(
                    'BAYAR SEKARANG',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Kasir POS')),
      body: isLayarLebar
          ? Row(
              children: [
                Expanded(flex: 3, child: daftarProdukWidget),
                const VerticalDivider(width: 1),
                Expanded(flex: 2, child: areaKeranjangWidget),
              ],
            )
          : Column(
              children: [
                Expanded(flex: 5, child: daftarProdukWidget),
                const Divider(height: 1),
                Expanded(flex: 4, child: areaKeranjangWidget),
              ],
            ),
    );
  }
}
