import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_grpc_client_robert_version/controllers/products/products_bloc.dart';

class SearchProductScreen extends StatelessWidget {
  const SearchProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsBloc = context.watch<ProductsBloc>();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          const Center(child: Text('SearchProductScreen')),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: TextField(
              onChanged: (v) {
                if (v.length == 24) {
                  productsBloc.callProduct(v);
                }
              },
            ),
          ),
          BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              if (state.runtimeType is LoadsProductState) {
                return Column(
                  children: [
                    Text(state.product?.id ?? ""),
                    Text(state.product?.name ?? ""),
                    Text(state.product?.price.toString() ?? ""),
                  ],
                );
              } else {
                return Container();
              }
            },
          )
        ],
      ),
    );
  }
}
