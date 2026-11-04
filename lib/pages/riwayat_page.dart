import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RiwayatPage extends StatelessWidget {
  const RiwayatPage({super.key});

  String _formatRupiah(double angka) {
    return NumberFormat.currency(
      locale: 'id',
      symbol: 'Rp ',
      decimalDigits: 0,
    ).format(angka);
  }

  @override
  Widget build(BuildContext context) {
    final daftarRiwayat = [
      {
        'id': 'TRX-001',
        'tanggal': '04 Nov 2026, 14:30',
        'item': '2x Kopi Susu Gula Aren, 1x Roti Bakar',
        'total': 51000.0,
        'metode': 'Tunai',
      },
      {
        'id': 'TRX-002',
        'tanggal': '04 Nov 2026, 15:15',
        'item': '1x Ayam Geprek, 1x Es Teh Manis',
        'total': 30000.0,
        'metode': 'QRIS',
      },
      {
        'id': 'TRX-003',
        'tanggal': '04 Nov 2026, 16:00',
        'item': '3x Kentang Goreng',
        'total': 36000.0,
        'metode': 'Tunai',
      },
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Penjualan')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: daftarRiwayat.length,
        itemBuilder: (context, index) {
          final trx = daftarRiwayat[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: CircleAvatar(
                backgroundColor: const Color(0xFF1E3A8A).withOpacity(0.1),
                child: const Icon(Icons.receipt, color: Color(0xFF1E3A8A)),
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    trx['id'].toString(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    trx['tanggal'].toString(),
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      trx['item'].toString(),
                      style: const TextStyle(color: Colors.black87),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.blue.shade200),
                          ),
                          child: Text(
                            trx['metode'].toString(),
                            style: const TextStyle(
                              fontSize: 11,
                              color: Color(0xFF1E3A8A),
                            ),
                          ),
                        ),
                        Text(
                          _formatRupiah(double.parse(trx['total'].toString())),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
