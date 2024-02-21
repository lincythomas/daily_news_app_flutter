import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/external_interface/api_external_interface.dart';
import 'package:daily_news_app/features/news_list/provider/news_list_gateway_provider.dart';

final newsListExternalInterfaceProvider = ExternalInterfaceProvider(
    ApiExternalInterface.new,
    gateways: [newsListGatewayProvider]);
