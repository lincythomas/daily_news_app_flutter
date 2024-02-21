import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:daily_news_app/features/news_list/domain/new_list_ui_output.dart';
import 'package:daily_news_app/features/news_list/domain/news_list_entity.dart';
import 'package:daily_news_app/features/news_list/domain/news_list_usecase.dart';
import 'package:daily_news_app/features/news_list/gateway/news_fetch_gateway.dart';
import 'package:daily_news_app/features/news_list/provider/news_list_usecase_provider.dart';
import 'package:daily_news_app/model/news_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final List<NewsData> newsList = [NewsData.sample()];

  // final outputNewsList = [
  //   // NewsData(
  //   //     author: "Filipe Espósito",
  //   //     title:
  //   //         "Apple Vision Pro glass may not break easily, but it’s highly susceptible to scratches",
  //   //     description:
  //   //         "As Apple Vision Pro is now available in stores and has reached the hands of thousands of customers in the U.S., we’ve seen multiple hands-on and, of course, some drop tests. Although the front glass on the Vision Pro has proven to be quite resistant to accide…",
  //   //     source: {},
  //   //     url: "",
  //   //     urlToImage:
  //   //         "https://i0.wp.com/9to5mac.com/wp-content/uploads/sites/6/2024/02/vision-pro-unboxing-0003.jpg?resize=1200%2C628&quality=82&strip=all&ssl=1",
  //   //     publishedAt: "08 Feb 2024 04:37 AM",
  //   //     content:
  //   //         "As Apple Vision Pro is now available in stores and has reached the hands of thousands of customers in the U.S., we’ve seen multiple hands-on and, of course, some drop tests. Although the front glass … [+1790 chars]")
  // ];

  final List<NewsData> outputList = [
    NewsData(
        author: "Filipe Espósito",
        title:
            "Apple Vision Pro glass may not break easily, but it’s highly susceptible to scratches",
        description:
            "As Apple Vision Pro is now available in stores and has reached the hands of thousands of customers in the U.S., we’ve seen multiple hands-on and, of course, some drop tests. Although the front glass on the Vision Pro has proven to be quite resistant to accide…",
        source: {},
        url: "",
        urlToImage:
            "https://i0.wp.com/9to5mac.com/wp-content/uploads/sites/6/2024/02/vision-pro-unboxing-0003.jpg?resize=1200%2C628&quality=82&strip=all&ssl=1",
        publishedAt: "08 Feb 2024 05:48 AM",
        content:
            "As Apple Vision Pro is now available in stores and has reached the hands of thousands of customers in the U.S., we’ve seen multiple hands-on and, of course, some drop tests. Although the front glass … [+1790 chars]")
  ];

  group('NewsListUsecase test |', () {
    useCaseTest<NewsListUseCase, NewsListEntity, NewsListUiOutput>(
      'fetchNews; success',
      provider: newsListUseCaseProvider,
      execute: (usecase) {
        _mockSuccess(usecase, newsList);
        return usecase.fetchNews(false);
      },
      expect: () => [
        const NewsListUiOutput(
            status: NewsListStatus.loading,
            newsList: [],
            selectedIndex: 0,
            isRefresh: false),
        NewsListUiOutput(
            status: NewsListStatus.loaded,
            newsList: newsList
                .map((newsData) => NewsData.updateDate(newsData))
                .toList(),
            selectedIndex: 0,
            isRefresh: false)
      ],
      // verify: (usecase) {
      //   expect(
      //       usecase.debugEntity.newsList[0].publishedAt,
      //       // NewsListEntity(
      //       //     status: NewsListStatus.loaded,
      //       //     newsList: outputList,
      //       //     selectedIndex: 0,
      //       //     isRefreshed: false),
      //       matches("08 Feb 2024 05:48 AM"));
      // },
    );

    useCaseTest<NewsListUseCase, NewsListEntity, NewsListUiOutput>(
      'fetchNews; failed',
      provider: newsListUseCaseProvider,
      execute: (usecase) {
        _mockFailure(usecase);
        return usecase.fetchNews(false);
      },
      expect: () => [
        const NewsListUiOutput(
            status: NewsListStatus.loading,
            newsList: [],
            selectedIndex: -1,
            isRefresh: false),
        const NewsListUiOutput(
            status: NewsListStatus.failed,
            newsList: [],
            selectedIndex: -1,
            isRefresh: false)
      ],
      verify: (usecase) {
        expect(
            usecase.debugEntity,
            const NewsListEntity(
                newsList: [],
                status: NewsListStatus.failed,
                selectedIndex: -1));
      },
    );
  });
}

void _mockSuccess(NewsListUseCase usecase, List<NewsData> newsList) {
  usecase.subscribe<NewsListGatewayOutput, NewsListSuccessInput>((p0) async {
    return Either.right(NewsListSuccessInput(newsList: newsList));
  });
}

void _mockFailure(NewsListUseCase useCase) {
  useCase.subscribe<NewsListGatewayOutput, NewsListSuccessInput>((p0) async {
    return const Either.left(FailureInput(message: 'No Internet'));
  });
}
