import 'dart:convert';

import 'package:htp/models/productmodel.dart';
import 'package:http/http.dart' as http;

class ProductRepo {
  Uri url = Uri.parse('https://fakestoreapi.com/products');
  Future<List<Products>> fetchProduct() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body).cast<Map<String, dynamic>>();

      // print(data);

      var products =
          data.map<Products>((json) => Products.fromJson(json)).toList();
      print('dfsdfsdfsdfsf:    $products');
      return products;
    } else {
      throw Exception('Failed to load');
    }

    // print(response.body[0]);
  }

  Future<void> addProduct(
      {String? title,
      double? price,
      String? category,
      String? image,
      String? description,
      Map? rating}) async {
    final response = await http.post(
      url,
      body: jsonEncode({
        "title": title,
        "price": price,
        "decsription": description,
        "category": category,
        "image": image,
        "rating": rating,
      }),
    );

    if (response.statusCode == 200) {
      print(response.body);
    }
  }

  Future<void> updateProduct({String? id, String? title, String? price}) async {
    final response = await http.put(
      Uri.parse(
        'https://fakestoreapi.com/products/$id',
      ),
      body: jsonEncode(
        <String, dynamic>{
          "title": title,
          "price": price,
        },
      ),
    );

    if (response.statusCode == 200) {
      print(response.body);
    }
  }

  Future<void> deleteProduct({String? id}) async {
    final response =
        await http.delete(Uri.parse('https://fakestoreapi.com/products/$id'));

    if (response.statusCode == 200) {
      print(response.body);
    }
  }
}
