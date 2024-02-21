import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:daily_news_app/features/news_detail/domain/news_detail_entity.dart';
import 'package:daily_news_app/features/news_detail/domain/news_detail_ui_output.dart';
import 'package:daily_news_app/features/news_detail/domain/news_detail_usecase.dart';
import 'package:daily_news_app/features/news_detail/presentation/news_detail_presenter.dart';
import 'package:daily_news_app/features/news_detail/presentation/news_detail_viewmodel.dart';
import 'package:daily_news_app/features/news_detail/providers/news_detail_usecase_provider.dart';
import 'package:daily_news_app/model/news_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  presenterTest<NewsDetailViewModel, NewsDetailUIOutput, NewsDetailUsecase>(
      'create viewmodel; success',
      create: (builder) =>
          NewsDetailPresenter(builder: builder, newsData: NewsData.sample()),
      overrides: [newsDetailUseCaseProvider.overrideWith(NewsDetailUsecase())],
      setup: (usecase) {
        usecase.debugEntityUpdate(
            (e) => e.copyWith(status: NewsDetailStatus.initial));
      },
      expect: () => {
            // isA<NewsDetailViewModel>().having((vm) => vm.isLoading, "initial setup of viewmodel", false);
            isA<NewsDetailViewModel>().having(
                (vm) => vm.isLoading, "initial setup of viewmodel", false)
          });

  presenterTest<NewsDetailViewModel, NewsDetailUIOutput, NewsDetailUsecase>(
      'when loading finishes',
      create: (builder) => NewsDetailPresenter(
            builder: builder,
            newsData: NewsData.sample(),
          ),
      overrides: [newsDetailUseCaseProvider.overrideWith(NewsDetailUsecase())],
      setup: (usecase) {
        usecase.debugEntityUpdate(
            (e) => e.copyWith(status: NewsDetailStatus.loading));
      },
      expect: () => [
            isA<NewsDetailViewModel>().having(
                (vm) => vm.isLoading, "viewmodel is loading; false", false),
            isA<NewsDetailViewModel>().having(
                (vm) => vm.isLoading, 'viewmodel is loading; true', true),
          ]);
}
