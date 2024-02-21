import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/features/news_detail/domain/news_detail_entity.dart';
import 'package:daily_news_app/features/news_detail/domain/news_detail_ui_output.dart';
import 'package:daily_news_app/features/news_detail/domain/news_detail_usecase.dart';
import 'package:daily_news_app/features/news_detail/presentation/news_detail_viewmodel.dart';
import 'package:daily_news_app/features/news_detail/providers/news_detail_usecase_provider.dart';
import 'package:daily_news_app/model/news_data.dart';

class NewsDetailPresenter extends Presenter<NewsDetailViewModel,
    NewsDetailUIOutput, NewsDetailUsecase> {
  NewsDetailPresenter({
    super.key,
    required super.builder,
    required NewsData newsData,
  }) : super(provider: newsDetailUseCaseProvider);

  @override
  NewsDetailViewModel createViewModel(
      NewsDetailUsecase useCase, NewsDetailUIOutput output) {
    return NewsDetailViewModel(
        isLoading: output.status == NewsDetailStatus.loading);
  }
}
