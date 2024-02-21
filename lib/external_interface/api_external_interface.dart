import 'dart:async';

import 'package:clean_framework_http/clean_framework_http.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiExternalInterface extends HttpExternalInterface {
  ApiExternalInterface() : super(delegate: _ApiExternalInterfaceDelegate());
}

class _ApiExternalInterfaceDelegate extends HttpExternalInterfaceDelegate {
  _ApiExternalInterfaceDelegate();

  @override
  Future<HttpOptions> buildOptions() async {
    return const HttpOptions(
      // baseUrl: "https://newsapi.org/v2/",
      baseUrl: 'http://saurav.tech/NewsAPI/',
    );
  }

  @override
  Future<Dio> buildDio(BaseOptions options) async {
    final dio = await super.buildDio(options);
    return dio
      ..interceptors.add(
        PrettyDioLogger(
          responseBody: false,
          requestHeader: true,
          requestBody: false,
          compact: true,
        ),
      );
  }
}
