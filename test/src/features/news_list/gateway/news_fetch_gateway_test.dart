import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_http/clean_framework_http.dart';
import 'package:daily_news_app/features/news_list/gateway/news_fetch_gateway.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NewsGateway tests', () {
    test('verify request', () {
      final gateway = NewsFetchGateway();
      const gatewayOutput = NewsListGatewayOutput(category: "");

      final request = gateway.buildRequest(gatewayOutput);

      expect(request.path, equals('/v2/top-headlines'));
    });

    test('success', () async {
      final gateway = NewsFetchGateway()
        ..feedResponse((request) => const Either.right(JsonHttpSuccessResponse({
              "status": "ok",
              "totalResults": 37,
              "articles": [
                {
                  "source": {"id": "cnn", "name": "CNN"},
                  "author": "By Antoinette",
                  "title":
                      "Life-threatening flood threat for California as heavy rain and winds batter the state: Live updates - CNN",
                  "description":
                      "An intense, long-lasting atmospheric river moved into California Sunday, bringing the potential for life-threatening flooding, landslides and widespread power outages. Follow here for the latest.",
                  "url":
                      "https://www.cnn.com/us/live-news/california-atmospheric-river-storms-flooding-rain-02-04-24/index.html",
                  "urlToImage":
                      "https://cdn.cnn.com/cnnnext/dam/assets/240125162029-23-week-in-photos-012524-super-tease.jpg",
                  "publishedAt": "2024-02-05T08:30:00Z",
                  "content":
                      "The National Weather Service has warned of \"numerous damaging landslides\" in the cities of Malibu and Beverly Hills as a powerful storm drenches California.\r\nLandslides could also hit from the Santa … [+1462 chars]"
                }
              ]
            }, 200)));

      final input =
          await gateway.buildInput(const NewsListGatewayOutput(category: ""));
      expect(input.isRight, true);

      final newsList = input.right.newsList;
      expect(newsList.first.author, equals('By Antoinette'));
    });
  });

  test('failure', () async {
    final gateway = NewsFetchGateway()
      ..feedResponse((request) async =>
          Either.left(UnknownFailureResponse("No Internet")));

    final input =
        await gateway.buildInput(const NewsListGatewayOutput(category: ""));
    expect(input.isLeft, true);
    expect(input.left.message, 'No Internet');
  });
}
