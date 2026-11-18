import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/book.dart';
import '../providers/cart_provider.dart';
import '../providers/theme_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Belanja'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, theme, _) => IconButton(
              tooltip: theme.isDarkMode ? 'Light Mode' : 'Dark Mode',
              icon: Icon(theme.isDarkMode ? Icons.light_mode : Icons.dark_mode),
              onPressed: () => context.read<ThemeProvider>().toggleTheme(),
            ),
          ),
        ],
      ),
      body: cart.items.isEmpty
          ? const Center(child: Text('Keranjang masih kosong'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: ListTile(
                          leading: Icon(item.book.icon, size: 32),
                          title: Text(item.book.title),
                          subtitle: Text(
                            '${formatRupiah(item.book.price)} x ${item.quantity}'
                            ' = ${formatRupiah(item.book.price * item.quantity)}',
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () => context
                                    .read<CartProvider>()
                                    .removeItem(item.book),
                              ),
                              Text(
                                '${item.quantity}',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () => context
                                    .read<CartProvider>()
                                    .addItem(item.book),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Ringkasan total & tombol checkout
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.surfaceContainerHighest,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Item'),
                            Text('${cart.totalItems}'),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total Pembayaran',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(
                              formatRupiah(cart.totalPrice),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                            icon: const Icon(Icons.payment),
                            label: const Text('Checkout / Bayar'),
                            onPressed: () {
                              final total = cart.totalPrice;
                              context.read<CartProvider>().clearCart();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Checkout berhasil! Total ${formatRupiah(total)}'),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
