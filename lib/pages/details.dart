import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/core/apis/products.dart';
import 'package:ecommerce/core/providers/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetails extends ConsumerWidget {
  final int id;
  const ProductDetails(this.id, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdts = ref.watch(productsProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          initialData: pdts.value?.firstWhere((element) => element.id == id),
          future: ProductApi.fetchProductById(id),
          builder: (_, res) {
            if (!res.hasData) {
              return const Center(child: Text("Product not found."));
            }
            final pdt = res.data!;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (pdt.images.isNotEmpty) ...[
                      CarouselSlider.builder(
                        options: CarouselOptions(height: 250.0, autoPlay: true),
                        itemCount: pdt.images.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          final im = pdt.images[itemIndex];
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                image: DecorationImage(
                                    image: NetworkImage(im),
                                    fit: BoxFit.cover)),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                    Center(
                      child: Text(
                        pdt.title,
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ),
                    const SizedBox(height: 10),
                    RichText(
                        text: TextSpan(
                            text: 'Price: ',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(fontSize: 18),
                            children: [
                          TextSpan(
                            text: "\$${pdt.price}",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.green),
                          )
                        ])),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "Description",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        pdt.description,
                        textAlign: TextAlign.justify,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
