import 'dart:async';
import 'dart:developer';

import 'package:flutter_grpc_client_robert_version/generated/product.pbgrpc.dart';
import 'package:grpc/grpc.dart';

class ProductsService {
  final ClientChannel _channel;

  ProductsService(this._channel);

  Stream<Product> getProducts() async* {
    final stub = ProductServiceClient(_channel);

    StreamController<Product> product = StreamController<Product>.broadcast();

    stub
        .listProduct(ListProductRequest())
        .listen((value) => product.add(value.product));

    yield* product.stream;
  }

  Future<Product> createProduct(Product product) async {
    DateTime t = DateTime.now();
    final stub = ProductServiceClient(_channel);

    CreateProductResponse response =
        await stub.createProduct(CreateProductRequest(product: product));
    log("${((DateTime.now().millisecondsSinceEpoch - t.millisecondsSinceEpoch) / 1000)}"
        " seconds");
    return response.product;
  }

  Future<Product> getProduct(String id) async {
    final stub = ProductServiceClient(_channel);
    final request = GetProductRequest(productId: id);
    final GetProductResponse response = await stub.getProduct(request);
    return response.product;
  }
}
