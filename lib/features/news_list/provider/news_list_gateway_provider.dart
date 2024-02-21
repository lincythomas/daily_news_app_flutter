import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/features/news_list/gateway/news_fetch_gateway.dart';
import 'package:daily_news_app/features/news_list/provider/news_list_usecase_provider.dart';

final newsListGatewayProvider =
    GatewayProvider(NewsFetchGateway.new, useCases: [
  newsListUseCaseProvider,
  newsDetailUseCaseProvider,
]);
