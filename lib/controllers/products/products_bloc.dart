import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:math';

import 'package:flutter_grpc_client_robert_version/generated/product.pbgrpc.dart';
import 'package:flutter_grpc_client_robert_version/services/products_service.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductsService repository;

  StreamController<List<Product>> productsStreamContreller =
      StreamController<List<Product>>.broadcast();

  ProductsBloc({required this.repository}) : super(ProductsInitial()) {
    on<InitProductsEvent>((event, emit) => emit(ProductsInitial()));
    on<CallProductsEvent>((event, emit) => emit(
        LoadsProductsState(products: event.products, product: state.product)));
    on<CallProductEvent>((event, emit) => emit(
        LoadsProductState(products: state.products, product: event.product)));
  }

  Stream<List<Product>> callProducts() async* {
    final List<Product> products = [];
    final result = repository.getProducts();

    result.listen((event) {
      products.add(event);
      productsStreamContreller.sink.add(products);
    });

    yield* productsStreamContreller.stream;
  }

  createProduct() async {
    final rng = Random();
    final result = await repository.createProduct(Product(
        name: rng.nextInt(5000).toString(),
        price: double.parse(rng.nextInt(5000).toString())));
  }

  Future<void> callProduct(String id) async {
    final result = await repository.getProduct(id);

    add(CallProductEvent(product: result));
  }
}
