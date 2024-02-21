import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:daily_news_app/features/news_list/domain/new_list_ui_output.dart';
import 'package:daily_news_app/features/news_list/domain/news_list_entity.dart';
import 'package:daily_news_app/features/news_list/domain/news_list_usecase.dart';
import 'package:daily_news_app/features/news_list/presentation/new_list_presenter.dart';
import 'package:daily_news_app/features/news_list/presentation/news_list_viewmodel.dart';
import 'package:daily_news_app/features/news_list/provider/news_list_usecase_provider.dart';
import 'package:daily_news_app/model/news_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final sampleList = [
    NewsData(
        author: "Lincy",
        title: "title breaking",
        description: "description1",
        source: {},
        url: "url1",
        urlToImage: "urlToImage1",
        publishedAt: "1",
        content: "content1"),
    NewsData(
        author: "Lincy",
        title: "title breaking",
        description: "description2",
        source: {},
        url: "url1",
        urlToImage: "urlToImage1",
        publishedAt: "1",
        content: "content1")
  ];

  group('news list presenter test', () {
    presenterTest<NewsListViewModel, NewsListUiOutput, NewsListUseCase>(
        'create view model',
        create: (builder) => NewsListPresenter(builder: builder),
        overrides: [
          newsListUseCaseProvider.overrideWith(NewsListUseCaseFake())
        ],
        setup: (useCase) {
          useCase.debugEntityUpdate((e) => e.copyWith(newsList: sampleList));
        },
        expect: () => [
              isA<NewsListViewModel>().having(
                  (viewModel) => viewModel.newsList, "is news list empty", []),
              isA<NewsListViewModel>().having(
                  (viewModel) => viewModel.newsList.map((e) => e.description),
                  'checking news list content',
                  ['description1', 'description2'])
            ]);
  });

  presenterTest<NewsListViewModel, NewsListUiOutput, NewsListUseCase>(
    'news refresh success',
    create: (builder) => NewsListPresenter(builder: builder),
    overrides: [newsListUseCaseProvider.overrideWith(NewsListUseCaseFake())],
    setup: ((useCase) {
      useCase.debugEntityUpdate(
          (e) => e.copyWith(status: NewsListStatus.loaded, isRefresh: true));
    }),
    verify: (tester) {
      expect(find.text("News refreshed successfully!!"), findsOneWidget);
    },
  );

  presenterTest<NewsListViewModel, NewsListUiOutput, NewsListUseCase>(
    'news refresh failed',
    create: (builder) => NewsListPresenter(builder: builder),
    overrides: [newsListUseCaseProvider.overrideWith(NewsListUseCaseFake())],
    setup: ((useCase) {
      useCase.debugEntityUpdate(
          (e) => e.copyWith(status: NewsListStatus.failed, isRefresh: true));
    }),
    verify: (tester) {
      expect(find.text("News refresh failed!!"), findsOneWidget);
    },
  );
}

class NewsListUseCaseFake extends NewsListUseCase {
  @override
  Future<void> fetchNews(bool isRefresh) async {}
}
