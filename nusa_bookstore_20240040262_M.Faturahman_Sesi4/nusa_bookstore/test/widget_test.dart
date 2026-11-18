import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:nusa_bookstore/main.dart';
import 'package:nusa_bookstore/providers/cart_provider.dart';
import 'package:nusa_bookstore/providers/theme_provider.dart';

void main() {
  testWidgets('Tambah buku ke keranjang memperbarui badge', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartProvider()),
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const NusaBookstoreApp(),
      ),
    );

    expect(find.text('Laskar Pelangi'), findsOneWidget);

    await tester.tap(find.text('Tambah ke Keranjang').first);
    await tester.pump();

    expect(find.text('1'), findsOneWidget); // badge jumlah item
  });
}
