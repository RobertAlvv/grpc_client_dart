import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_grpc_client_robert_version/controllers/products/products_bloc.dart';
import 'package:flutter_grpc_client_robert_version/screens/search_product_screen.dart';
import 'package:grpc/grpc.dart';

import '../generated/product.pbgrpc.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  List<Product> items = [];
//631638ee243f7e7d672df731
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Productos GRPC"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const SearchProductScreen()));
              },
              icon: const Icon(Icons.search)),
          IconButton(
              onPressed: () {
                context.read<ProductsBloc>().createProduct();
              },
              icon: const Icon(Icons.add)),
          const SizedBox(width: 20)
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: StreamBuilder<List<Product>>(
                stream: context.watch<ProductsBloc>().callProducts(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Product>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        log(snapshot.data![index].toString());
                        final product = snapshot.data![index];
                        return ListTile(
                          title: Text(product.name),
                          subtitle: Text(product.price.toString()),
                          trailing: IconButton(
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.red,
                            ),
                            onPressed: () {},
                          ),
                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
