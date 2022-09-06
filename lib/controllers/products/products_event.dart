part of 'products_bloc.dart';

abstract class ProductsEvent {}

class InitProductsEvent extends ProductsEvent {}

class CallProductsEvent extends ProductsEvent {
  final List<Product> products;
  CallProductsEvent({required this.products});
}

class CallProductEvent extends ProductsEvent {
  final Product product;
  CallProductEvent({required this.product});
}
