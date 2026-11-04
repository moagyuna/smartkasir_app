import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilTokoPage extends StatefulWidget {
  const ProfilTokoPage({super.key});

  @override
  State<ProfilTokoPage> createState() => _ProfilTokoPageState();
}

class _ProfilTokoPageState extends State<ProfilTokoPage> {
  final TextEditingController _namaTokoController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _muatDataToko();
  }

  Future<void> _muatDataToko() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _namaTokoController.text =
          prefs.getString('nama_toko') ?? 'SmartKasir Store';
      _alamatController.text =
          prefs.getString('alamat_toko') ??
          'Jl. Brigjend H. Hasan Basri, Banjarmasin';
      _isLoading = false;
    });
  }

  Future<void> _simpanDataToko() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nama_toko', _namaTokoController.text);
    await prefs.setString('alamat_toko', _alamatController.text);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profil toko berhasil diperbarui!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Toko')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Color(0xFF1E3A8A),
                      child: Icon(Icons.store, size: 40, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _namaTokoController,
                    decoration: const InputDecoration(
                      labelText: 'Nama Toko',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.business),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _alamatController,
                    decoration: const InputDecoration(
                      labelText: 'Alamat Toko',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.location_on),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A8A),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: _simpanDataToko,
                      icon: const Icon(Icons.save),
                      label: const Text('Simpan Perubahan'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
