import 'dart:convert';
import 'package:ecommerce/core/models/products.dart';
import 'package:http/http.dart' as http;

class ProductApi {
  static String _list(int offset) =>
      'https://api.escuelajs.co/api/v1/products?offset=$offset&limit=10';

  static String _pdtById(int id) =>
      'https://api.escuelajs.co/api/v1/products/$id';

  static Future<List<ProductResponseModel>> fetchProductsList(
      {int offset = 0}) async {
    final response = await http.get(Uri.parse(_list(offset)));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => ProductResponseModel.fromMap(item)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<ProductResponseModel> fetchProductById(int id) async {
    final response = await http.get(Uri.parse(_pdtById(id)));
    if (response.statusCode == 200) {
      dynamic data = jsonDecode(response.body);
      return ProductResponseModel.fromMap(data);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
