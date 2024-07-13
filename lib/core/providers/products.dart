import 'package:ecommerce/core/apis/products.dart';
import 'package:ecommerce/core/models/products.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'products.g.dart';

@riverpod
class Products extends _$Products {
  @override
  Future<List<ProductResponseModel>> build() async {
    return await ProductApi.fetchProductsList();
  }

  void loadMore() async {
    final offset = state.requireValue.length;
    state = await AsyncValue.guard(() async {
      final next = await ProductApi.fetchProductsList(offset: offset);
      return [...state.valueOrNull ?? [], ...next];
    });
  }
}
