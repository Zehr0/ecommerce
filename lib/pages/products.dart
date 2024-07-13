import 'package:ecommerce/core/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductsPage extends ConsumerWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdts = ref.watch(productsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        centerTitle: true,
      ),
      body: pdts.when(
          data: (data) {
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, i) {
                  final pdt = data[i];
                  return ListTile(
                    title: Text(pdt.title),
                    subtitle: Text(
                      pdt.description,
                      maxLines: 1,
                    ),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(pdt.images.first),
                    ),
                  );
                });
          },
          error: (o, s) {
            return const Center(child: Text('Something went wrong!!!'));
          },
          loading: () => const Center(child: CircularProgressIndicator())),
    );
  }
}