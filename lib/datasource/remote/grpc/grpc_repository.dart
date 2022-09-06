import 'dart:convert';
import 'package:grpc/grpc.dart';

class GrpcRepository {
  late ClientChannel _channel;

  static final _instancia = GrpcRepository._();

  factory GrpcRepository() => _instancia;

  GrpcRepository._() {
    _channel = ClientChannel(
      '10.0.0.101',
      port: 50051,
      options: const ChannelOptions(credentials: ChannelCredentials.insecure()),
    );
  }

  ClientChannel get channel => _channel;
}
