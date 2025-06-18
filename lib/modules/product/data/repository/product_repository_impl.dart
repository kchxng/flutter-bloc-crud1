import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';
import 'package:ticketbooking_app/core/error/exceptions.dart';
import 'package:ticketbooking_app/core/error/failures.dart';
import 'package:ticketbooking_app/core/network/network_info.dart';
import 'package:ticketbooking_app/modules/product/data/datasource/product_local_datasource.dart';
import 'package:ticketbooking_app/modules/product/data/datasource/product_remote_datasource.dart';
import 'package:ticketbooking_app/modules/product/data/models/product_model.dart';
import 'package:ticketbooking_app/modules/product/domain/entity/product.dart';
import 'package:ticketbooking_app/modules/product/domain/repository/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDatasource remoteDatasource;
  final ProductLocalDatasource localDatasource;
  final NetworkInfo networkInfo;
  final logs = Logger();

  // Constructor
  ProductRepositoryImpl({
    required this.remoteDatasource,
    required this.localDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final products = await remoteDatasource.getProducts();
        // Load from cache
        localDatasource.cacheProducts(products);
        return Right(products);
      } on ServerException {
        logs.e('Internal Server Error');
        return Left(ServerFailure());
      }
    } else {
      try {
        final products = await localDatasource.getCachedProducts();
        return Right(products);
      } on CacheException {
        logs.e('Cache Error');
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Product>> addProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final productModel = ProductModel(
          id: product.id,
          name: product.name,
          description: product.description,
          price: product.price,
          category: product.category,
          imageUrl: product.imageUrl,
          imagePath: product.imagePath,
          stock: product.stock,
          isActive: product.isActive,
        );
        final result = await remoteDatasource.addProduct(productModel);
        return Right(result);
      } on ServerException {
        logs.e('Internal Server Error');
        return Left(ServerFailure());
      }
    } else {
      logs.e('Cache Error');
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, Product>> updateProduct(Product product) async {
    if (await networkInfo.isConnected) {
      try {
        final productModel = ProductModel(
          id: product.id,
          name: product.name,
          description: product.description,
          price: product.price,
          category: product.category,
          imageUrl: product.imageUrl,
          imagePath: product.imagePath,
          stock: product.stock,
          isActive: product.isActive,
        );
        final result = await remoteDatasource.updateProduct(productModel);
        return Right(result);
      } on ServerException {
        logs.e('Internal Server Error');
        return Left(ServerFailure());
      }
    } else {
      logs.e('Cache Error');
      return Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDatasource.deleteProduct(id);
        return Right(null);
      } on ServerException {
        logs.e('Internal Server Error');
        return Left(ServerFailure());
      }
    } else {
      logs.e('Cache Error');
      return Left(NetworkFailure());
    }
  }
}
