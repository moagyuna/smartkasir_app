class Produk {
  final String nama;
  final double harga;
  final int stok;
  final String kategori;
  int diskonPersen;

  Produk({
    required this.nama,
    required this.harga,
    required this.stok,
    required this.kategori,
    this.diskonPersen = 0,
  });
}

// Daftar 6 produk dummy (data awal)
final List<Produk> daftarProdukDummy = [
  Produk(
    nama: 'Kopi Susu Gula Aren',
    harga: 18000,
    stok: 50,
    kategori: 'Minuman',
  ),
  Produk(
    nama: 'Roti Bakar Coklat',
    harga: 15000,
    stok: 20,
    kategori: 'Makanan',
  ),
  Produk(
    nama: 'Mie Goreng Spesial',
    harga: 20000,
    stok: 30,
    kategori: 'Makanan',
  ),
  Produk(nama: 'Es Teh Manis', harga: 5000, stok: 100, kategori: 'Minuman'),
  Produk(nama: 'Kentang Goreng', harga: 12000, stok: 40, kategori: 'Cemilan'),
  Produk(nama: 'Ayam Geprek', harga: 25000, stok: 15, kategori: 'Makanan'),
];
