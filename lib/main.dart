import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_grpc_client_robert_version/controllers/products/products_bloc.dart';
import 'package:flutter_grpc_client_robert_version/datasource/remote/grpc/grpc_repository.dart';
import 'package:flutter_grpc_client_robert_version/screens/products_screen.dart';
import 'package:flutter_grpc_client_robert_version/services/products_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyRepositoriesApp());
}

class MyRepositoriesApp extends StatelessWidget {
  const MyRepositoriesApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(providers: [
      RepositoryProvider(
          create: (_) => ProductsService(GrpcRepository().channel))
    ], child: const MyBlocsApp());
  }
}

class MyBlocsApp extends StatelessWidget {
  const MyBlocsApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider<ProductsBloc>(
          create: (_) =>
              ProductsBloc(repository: context.read<ProductsService>())),
    ], child: const App());
  }
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProductsScreen(),
    );
  }
}
