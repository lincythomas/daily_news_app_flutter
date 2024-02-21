import 'dart:async';

import 'package:clean_framework_http/clean_framework_http.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class TechCrunchApiExternalInterface extends HttpExternalInterface {
  TechCrunchApiExternalInterface()
      : super(delegate: _TechCrunchApiExternalInterfaceDelegate());
}

class _TechCrunchApiExternalInterfaceDelegate
    extends HttpExternalInterfaceDelegate {
  _TechCrunchApiExternalInterfaceDelegate();

  @override
  Future<HttpOptions> buildOptions() async {
    return const HttpOptions(
      baseUrl: 'https://techcrunch.com/wp-json/wp/v2/',
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
