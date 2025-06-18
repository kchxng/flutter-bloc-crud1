import 'dart:convert';

import 'package:ticketbooking_app/core/error/exceptions.dart';
import 'package:ticketbooking_app/core/utils/constants.dart';
import 'package:ticketbooking_app/modules/product/data/models/product_model.dart';
import 'package:http/http.dart' as http;

abstract class ProductRemoteDatasource {
  Future<List<ProductModel>> getProducts();
  Future<ProductModel> addProduct(ProductModel product);
  Future<ProductModel> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}

// Impl
class ProductRemoteDatasourceImpl implements ProductRemoteDatasource {
  final http.Client client;
  ProductRemoteDatasourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getProducts() async {
    final res = await client.get(
      Uri.parse('${Constants.baseUrl}/products'),
      headers: {'Content-Type': 'application/json'},
    );
    if (res.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(res.body);
      return jsonList.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> addProduct(ProductModel product) async {
    final res = await client.post(
      Uri.parse('${Constants.baseUrl}/products'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()), // send body to back-end
    );
    if (res.statusCode == 201 || res.statusCode == 200) {
      return ProductModel.fromJson(json.decode(res.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<ProductModel> updateProduct(ProductModel product) async {
    final res = await client.put(
      Uri.parse('${Constants.baseUrl}/products/$product.id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(product.toJson()), // send body to back-end
    );
    if (res.statusCode == 200) {
      return ProductModel.fromJson(json.decode(res.body));
    }
    throw ServerException();
  }

  @override
  Future<void> deleteProduct(String id) async {
    final res = await client.delete(
      Uri.parse('${Constants.baseUrl}products/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (res.statusCode != 200 || res.statusCode != 204) {
      throw ServerException();
    }
  }
}
