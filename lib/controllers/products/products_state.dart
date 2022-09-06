part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  final List<Product> products;
  final Product? product;
  const ProductsState({required this.products, required this.product});
}

class ProductsInitial extends ProductsState {
  ProductsInitial() : super(products: [], product: null);

  @override
  List<Object> get props => [];
}

class LoadsProductsState extends ProductsState {
  final List<Product> products;
  final Product? product;
  const LoadsProductsState({required this.products, required this.product})
      : super(products: products, product: product);

  @override
  List<Object?> get props => [products, product];
}

class LoadsProductState extends ProductsState {
  final List<Product> products;
  final Product? product;
  const LoadsProductState({required this.products, required this.product})
      : super(products: products, product: product);

  @override
  List<Object?> get props => [products, product];
}
