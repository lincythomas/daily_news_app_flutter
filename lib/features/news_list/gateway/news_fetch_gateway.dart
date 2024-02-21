import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_http/clean_framework_http.dart';
import 'package:daily_news_app/model/news_data.dart';

class NewsFetchGateway extends Gateway<NewsListGatewayOutput, NewsListRequest,
    SuccessResponse, NewsListSuccessInput> {
  final newsDataAPiKy = "pub_38030e1c737513bbf941cfeabfe65b9ec7c35";

  @override
  NewsListRequest buildRequest(NewsListGatewayOutput output) {
    return NewsListRequest(
        category: output.category,
        callFrom: output.callFrom,
        page: output.page);
  }

  @override
  FailureInput onFailure(covariant FailureResponse failureResponse) {
    return FailureInput(message: failureResponse.message);
  }

  @override
  NewsListSuccessInput onSuccess(JsonHttpSuccessResponse response) {
    final deserializer = Deserializer(response.data);
    return NewsListSuccessInput(
        newsList:
            deserializer.getList('articles', converter: NewsData.fromJson),
        totalResults: deserializer.getInt("totalResults"));
  }
}

class NewsListGatewayOutput extends Output {
  final String callFrom;
  final String category;
  final int page;

  const NewsListGatewayOutput(
      {required this.category, required this.callFrom, required this.page});
  @override
  List<Object?> get props => [category, callFrom, page];
}

class NewsListRequest extends GetHttpRequest {
  final String category;
  final String callFrom;
  final int page;

  const NewsListRequest(
      {super.cancelToken,
      required this.category,
      required this.callFrom,
      required this.page});

  @override
  String get path => callFrom == "bbc"
      ? 'everything/bbc-news.json'
      : 'top-headlines/category/$category/in.json';
}

class NewsListSuccessResponse extends SuccessResponse {}

class NewsListSuccessInput extends SuccessInput {
  final List<NewsData> newsList;
  final int totalResults;

  NewsListSuccessInput({required this.newsList, required this.totalResults});
}
