import 'package:equatable/equatable.dart';

class NetworkLogModel extends Equatable {

  const NetworkLogModel({
    this.statusCode,
    this.httpMethod,
    this.requestUrl,
    this.timestamp,
    this.requestHeaders,
    this.requestBody,
    this.responseHeaders,
    this.responseBody,
  });

  final int? statusCode;
  final String? httpMethod;
  final String? requestUrl;
  final String? timestamp;
  final String? requestHeaders;
  final dynamic requestBody;
  final String? responseHeaders;
  final dynamic responseBody;

  @override
  List<Object?> get props => <Object?>[
    statusCode,
    httpMethod,
    requestUrl
  ];
}