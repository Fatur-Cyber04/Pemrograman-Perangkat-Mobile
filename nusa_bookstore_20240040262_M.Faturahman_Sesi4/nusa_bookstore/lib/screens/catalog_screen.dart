import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart';
import 'cart_screen.dart';

const List<Book> bookList = [
  Book(
    id: 'b1',
    title: 'Laskar Pelangi',
    author: 'Andrea Hirata',
    price: 85000,
    icon: Icons.auto_stories,
  ),
  Book(
    id: 'b2',
    title: 'Bumi Manusia',
    author: 'Pramoedya Ananta Toer',
    price: 110000,
    icon: Icons.menu_book,
  ),
  Book(
    id: 'b3',
    title: 'Filosofi Teras',
    author: 'Henry Manampiring',
    price: 98000,
    icon: Icons.psychology,
  ),
  Book(
    id: 'b4',
    title: 'Atomic Habits',
    author: 'James Clear',
    price: 120000,
    icon: Icons.bolt,
  ),
  Book(
    id: 'b5',
    title: 'Negeri 5 Menara',
    author: 'Ahmad Fuadi',
    price: 79000,
    icon: Icons.school,
  ),
];

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NusaBookstore'),
        actions: [
          // Tombol Light/Dark Mode
          Consumer<ThemeProvider>(
            builder: (context, theme, _) => IconButton(
              tooltip: theme.isDarkMode ? 'Light Mode' : 'Dark Mode',
              icon: Icon(theme.isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => context.read<ThemeProvider>().toggleTheme(),
            ),
          ),
          // Ikon keranjang dengan badge jumlah item
          Consumer<CartProvider>(
            builder: (context, cart, _) => Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                tooltip: 'Keranjang',
                icon: Badge(
                  isLabelVisible: cart.totalItems > 0,
                  label: Text('${cart.totalItems}'),
                  child: const Icon(Icons.shopping_cart),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: bookList.length,
        itemBuilder: (context, index) {
          final book = bookList[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 90,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      book.icon,
                      size: 36,
                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          book.title,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(book.author),
                        const SizedBox(height: 4),
                        Text(
                          formatRupiah(book.price),
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        FilledButton.icon(
                          onPressed: () {
                            context.read<CartProvider>().addItem(book);
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${book.title} ditambahkan ke keranjang'),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                          },
                          icon: const Icon(Icons.add_shopping_cart, size: 18),
                          label: const Text('Tambah ke Keranjang'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
