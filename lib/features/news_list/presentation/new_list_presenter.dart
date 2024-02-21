import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/features/news_list/domain/new_list_ui_output.dart';
import 'package:daily_news_app/features/news_list/domain/news_list_entity.dart';
import 'package:daily_news_app/features/news_list/domain/news_list_usecase.dart';
import 'package:daily_news_app/features/news_list/presentation/news_list_viewmodel.dart';
import 'package:daily_news_app/features/news_list/provider/news_list_usecase_provider.dart';
import 'package:flutter/material.dart';

class NewsListPresenter
    extends Presenter<NewsListViewModel, NewsListUiOutput, NewsListUseCase> {
  NewsListPresenter({super.key, required super.builder})
      : super(provider: newsListUseCaseProvider);

  @override
  void onLayoutReady(BuildContext context, NewsListUseCase useCase) {
    useCase.initScrollController();
    useCase.fetchCategoryNews(false, isFromLoadMore: false);
    useCase.fetchBBCNews();
    // useCase.fetchNews(false, '', category: 'health');
  }

  @override
  NewsListViewModel createViewModel(
      NewsListUseCase useCase, NewsListUiOutput output) {
    return NewsListViewModel(
      hasLoadingFailed: output.status == NewsListStatus.failed,
      isLoading: output.status == NewsListStatus.loading,
      isTabDataLoading: output.status == NewsListStatus.tabDataLoading,
      newsList: output.newsList,
      selectedIndex: output.selectedIndex,
      onChipSelect: (value) {
        useCase.onChipSelect(value);
      },
      onRefresh: () {
        return useCase.fetchCategoryNews(true, isFromLoadMore: false);
      },
      onTabClicked: (value) => useCase.onTabClicked(value),
      bbcNewsList: output.bbcNewsList,
      healthNewsList: output.healthNewsList,
      scrollController: output.scrollController,
      isLoadingMore: output.status == NewsListStatus.loadMoreFailed,
      currentSelectedBottomTab: output.currentSelectedBottomTab,
      onBottomTabSelect: (value) => useCase.onBottomTabSelect(value),
    );
  }

  @override
  void onOutputUpdate(BuildContext context, NewsListUiOutput output) {
    if (output.status == NewsListStatus.loaded && output.isRefresh) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('News refreshed successfully!!')));
    }
    if (output.status == NewsListStatus.failed && output.isRefresh) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('News refresh failed!!')));
    }
  }
}
