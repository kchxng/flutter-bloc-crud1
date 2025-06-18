import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ticketbooking_app/core/usecase/usecase.dart';
import 'package:ticketbooking_app/modules/product/domain/usecase/add_product.dart';
import 'package:ticketbooking_app/modules/product/domain/usecase/delete_product.dart';
import 'package:ticketbooking_app/modules/product/domain/usecase/get_products.dart';
import 'package:ticketbooking_app/modules/product/domain/usecase/update_product.dart';
import 'package:ticketbooking_app/modules/product/presentation/bloc/product_event.dart';
import 'package:ticketbooking_app/modules/product/presentation/bloc/product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final GetProducts getProducts;
  final AddProduct addProduct;
  final UpdateProduct updateProduct;
  final DeleteProduct deleteProduct;

  ProductBloc({
    required this.getProducts,
    required this.addProduct,
    required this.updateProduct,
    required this.deleteProduct,
  }) : super(ProductInitial()) {
    on<GetProductsRequest>(_onGetProductsRequest);
    on<AddProductRequest>(_onAddProductRequest);
    on<UpdateProductRequest>(_onUpdateProductRequest);
    on<DeleteProductRequest>(_onDeleteProductRequest);
  }

  void _onGetProductsRequest(
    GetProductsRequest event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final result = await getProducts(NoParams());
    result.fold(
      (failure) => emit(const ProductError(message: 'Failed to load products')),
      (products) => emit(ProductLoaded(products: products)),
    );
  }

  void _onAddProductRequest(
    AddProductRequest event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final result = await addProduct(AddProductParams(product: event.product));
    result.fold(
      (failure) => emit(const ProductError(message: 'Failed to add products')),
      (_) => emit(ProductSuccess(message: 'add product success')),
    );
  }

  void _onUpdateProductRequest(
    UpdateProductRequest event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final result = await updateProduct(
      UpdateProductParams(product: event.product),
    );
    result.fold(
      (failure) => emit(const ProductError(message: 'Failed to load products')),
      (_) {
        emit(ProductSuccess(message: 'Update product success'));
        add(GetProductsRequest());
      },
    );
  }

  void _onDeleteProductRequest(
    DeleteProductRequest event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    final result = await getProducts(NoParams());
    result.fold(
      (failure) =>
          emit(const ProductError(message: 'Failed to delete products')),
      (_) {
        emit(ProductSuccess(message: 'Delete product success'));
        add(GetProductsRequest());
      },
    );
  }
}
