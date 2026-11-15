import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/// Data diri mahasiswa
const String kNama = 'M.Faturahman.N.M';
const String kNim = '20240040262';
const String kProdi = 'Teknik Informatika';
const String kKelas = 'TI24M';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PPM Sesi 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        scaffoldBackgroundColor: Colors.teal.shade50,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        title: const Text(
          'PPM Sesi 2 - $kNama ($kNim)',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            PromoBanner(),
            SizedBox(height: 16),
            ProfileCard(),
            SizedBox(height: 16),
            ProductCard(),
          ],
        ),
      ),
    );
  }
}

/// Banner promo menggunakan Stack dan Positioned
class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 130,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade700, Colors.teal.shade300],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              right: -20,
              bottom: -20,
              child: Icon(Icons.local_offer,
                  size: 130, color: Colors.teal.shade100),
            ),
            const Positioned(
              left: 16,
              top: 16,
              child: Text(
                'PROMO SPESIAL',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Positioned(
              left: 16,
              top: 52,
              child: Text(
                'Diskon hingga 30% hari ini!',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
            Positioned(
              left: 16,
              bottom: 14,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'HEMAT 30%',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Kartu profil mahasiswa (StatelessWidget)
class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundColor: Colors.teal.shade100,
              backgroundImage: const AssetImage('assets/images/profile.jpg'),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    kNama,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  const Text('NIM: $kNim'),
                  const Text('Prodi: $kProdi'),
                  const Text('Kelas: $kKelas'),
                  const SizedBox(height: 8),
                  Row(
                    children: List.generate(
                      5,
                      (index) => const Icon(Icons.star,
                          color: Colors.amber, size: 22),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Kartu produk (StatefulWidget)
class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  static const String _namaProduk = 'BMW M4 Competition';
  static const String _kategori = 'Otomotif';
  static const int _harga = 2500000000;

  // Pilihan warna: nama, gambar, dan warna tombolnya
  static const List<Map<String, dynamic>> _variants = [
    {
      'nama': 'Kuning',
      'gambar': 'assets/images/kuning.jpg',
      'warna': Color(0xFFD7E021),
    },
    {
      'nama': 'Putih',
      'gambar': 'assets/images/putih.jpg',
      'warna': Color(0xFFEFEFEF),
    },
    {
      'nama': 'Biru',
      'gambar': 'assets/images/biru.jpg',
      'warna': Color(0xFF2F9BDD),
    },
  ];

  int _selectedVariant = 0;

  bool _isFavorite = false;
  int _likeCount = 10;
  int _quantity = 1;

  String _formatRupiah(int value) {
    final s = value.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < s.length; i++) {
      if (i > 0 && (s.length - i) % 3 == 0) buffer.write('.');
      buffer.write(s[i]);
    }
    return 'Rp $buffer';
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
      _likeCount += _isFavorite ? 1 : -1;
    });
  }

  void _increment() {
    setState(() => _quantity++);
  }

  void _decrement() {
    if (_quantity > 1) {
      setState(() => _quantity--);
    }
  }

  void _addToCart() {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            '$_quantity $_namaProduk ${_variants[_selectedVariant]['nama']} ditambahkan ke keranjang (${_formatRupiah(_harga * _quantity)})'),
        backgroundColor: Colors.teal,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = _harga * _quantity;

    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar produk (berubah sesuai warna yang dipilih)
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.asset(
              _variants[_selectedVariant]['gambar'] as String,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text(
                        _namaProduk,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.teal.shade50,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.teal),
                      ),
                      child: const Text(
                        _kategori,
                        style: TextStyle(color: Colors.teal, fontSize: 12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  _formatRupiah(_harga),
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.teal,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),

                // Pilihan warna
                Row(
                  children: [
                    const Text('Warna: ',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    Text(_variants[_selectedVariant]['nama'] as String),
                    const Spacer(),
                    for (int i = 0; i < _variants.length; i++)
                      GestureDetector(
                        onTap: () => setState(() => _selectedVariant = i),
                        child: Container(
                          width: 30,
                          height: 30,
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: _variants[i]['warna'] as Color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: i == _selectedVariant
                                  ? Colors.teal
                                  : Colors.grey,
                              width: i == _selectedVariant ? 3 : 1,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),

                // Tombol Favorite + jumlah Like
                Row(
                  children: [
                    IconButton(
                      onPressed: _toggleFavorite,
                      icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: _isFavorite ? Colors.red : Colors.grey,
                      ),
                    ),
                    Text('$_likeCount Like'),
                  ],
                ),
                const Divider(),

                // Atur jumlah produk
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Jumlah',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    Row(
                      children: [
                        IconButton.outlined(
                          onPressed: _decrement,
                          icon: const Icon(Icons.remove),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '$_quantity',
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        IconButton.outlined(
                          onPressed: _increment,
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Harga',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    Text(
                      _formatRupiah(total),
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Tombol tambah ke keranjang
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: _addToCart,
                    icon: const Icon(Icons.add_shopping_cart),
                    label: const Text('Tambah ke Keranjang'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
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