import 'package:flutter/material.dart';

class Book {
  final String id;
  final String title;
  final String author;
  final int price;
  final IconData icon; // ikon placeholder pengganti gambar

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.price,
    this.icon = Icons.menu_book,
  });
}

/// Format angka menjadi Rupiah, contoh: 85000 -> Rp 85.000
String formatRupiah(int value) {
  final s = value.toString();
  final buffer = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i > 0 && (s.length - i) % 3 == 0) buffer.write('.');
    buffer.write(s[i]);
  }
  return 'Rp $buffer';
}
