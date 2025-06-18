import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:ticketbooking_app/core/error/exceptions.dart';
import 'package:ticketbooking_app/core/utils/constants.dart';
import 'package:ticketbooking_app/modules/product/data/models/product_model.dart';

abstract class ProductLocalDatasource {
  Future<List<ProductModel>> getCachedProducts();
  Future<void> cacheProducts(List<ProductModel> products);
}

class ProductLocalDatasourceImpl implements ProductLocalDatasource {
  final SharedPreferences sharedPreferences;
  ProductLocalDatasourceImpl({required this.sharedPreferences});

  // Get products from cache.
  @override
  Future<List<ProductModel>> getCachedProducts() {
    final jsonString = sharedPreferences.getString(Constants.cachedProduct);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      return Future.value(
        jsonList.map((json) => ProductModel.fromJson(json)).toList(),
      );
    }
    throw CacheException();
  }

  // Set products to cached
  @override
  Future<void> cacheProducts(List<ProductModel> products) {
    final productsJson = products.map((product) => product.toJson()).toList();
    return sharedPreferences.setString(
      Constants.cachedProduct,
      json.encode(productsJson),
    );
  }
}
