import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/features/news_list/domain/new_list_ui_output.dart';
import 'package:daily_news_app/features/news_list/domain/news_list_entity.dart';
import 'package:daily_news_app/features/news_list/gateway/news_fetch_gateway.dart';
import 'package:daily_news_app/model/news_data.dart';
import 'package:flutter/material.dart';

class NewsListUseCase extends UseCase<NewsListEntity> {
  NewsListUseCase()
      : super(
          entity: NewsListEntity(
              newsList: const [],
              bbcNewsList: const [],
              selectedIndex: 0,
              healthNewsList: const [],
              scrollController: ScrollController(),
              isLoadingMore: false,
              currentSelectedBottomTab: 0),
          transformers: [
            NewsListOutputTransformer(),
          ],
        );

  bool _loading = false;
  bool _lastPage = false;
  int _totalItems = 0;
  List<NewsData> outputNewsList = [];
  int page = 0;

  Future<void> fetchBBCNews() async {
    // if (!isFromRefresh && !isFromLoadMore) {
    //   // entity = entity.copyWith(status: NewsListStatus.loading);
    // }

    final input = await getInput(
        const NewsListGatewayOutput(category: "", callFrom: "bbc", page: 0));

    switch (input) {
      case Success(:NewsListSuccessInput input):
        {
          List<NewsData> filteredNonNullList = input.newsList
              .where((newsData) =>
                  (newsData.content != null && newsData.title != '[Removed]'))
              .toList();

          var changeDateInList = filteredNonNullList
              .map((newsData) => NewsData.updateDate(newsData))
              .toList();

          entity = entity.copyWith(
              bbcNewsList: changeDateInList,
              status: NewsListStatus.loaded,
              isRefresh: false);
          entity = entity.copyWith(isRefresh: false);
        }
      case _:
        entity =
            entity.copyWith(status: NewsListStatus.failed, isRefresh: false);
    }
  }

  Future<void> fetchCategoryNews(bool isFromRefresh,
      {bool isFromLoadMore = false, bool isFromTabClicked = false}) async {
    if (!isFromLoadMore) {
      _totalItems = 0;
      page = 0;
      _lastPage = false;
    }
    if (!isFromRefresh && !isFromLoadMore) {
      if (isFromTabClicked) {
        entity = entity.copyWith(status: NewsListStatus.tabDataLoading);
      } else {
        entity = entity.copyWith(status: NewsListStatus.loading);
      }
    }

    final input = await getInput(NewsListGatewayOutput(
        category: _getSelectedCategory(), callFrom: "", page: page));

    switch (input) {
      case Success(:NewsListSuccessInput input):
        {
          _totalItems = input.totalResults;
          List<NewsData> filteredNonNullList = input.newsList
              .where((newsData) =>
                  (newsData.content != null && newsData.title != '[Removed]'))
              .toList();

          var changeDateInList = filteredNonNullList
              .map((newsData) => NewsData.updateDate(newsData))
              .toList();

          outputNewsList = isFromLoadMore
              ? outputNewsList + changeDateInList
              : changeDateInList;

          print(
              "isFromLoadMore $isFromLoadMore outputNewsList length ${outputNewsList.length} and totalItems FromTabClicked=false $_totalItems");

          _updateLoadingAndLastPage();

          entity = entity.copyWith(
              newsList: outputNewsList,
              status: NewsListStatus.loaded,
              isRefresh: isFromRefresh);
          entity = entity.copyWith(isRefresh: false);
        }
      case _:
        {
          if (isFromLoadMore) {
            // outputNewsList.removeWhere((element) => element.showLoader == true);
          } else {
            entity = entity.copyWith(
                status: NewsListStatus.failed, isRefresh: isFromRefresh);
          }
        }
    }
  }

  void _updateLoadingAndLastPage() {
    _loading = false;
    entity.copyWith(isLoadingMore: false);
    if (checkIfLastPage) {
      _lastPage = true;
    }
  }

  bool get checkIfLastPage => outputNewsList.length == _totalItems;

  void initScrollController() {
    // entity.scrollController.addListener(_scrollListener);
  }

  Future<void> _scrollListener() async {
    if (_lastPage) {
      return;
    }
    var controller = entity.scrollController;
    if (controller.position.pixels == controller.position.maxScrollExtent &&
        !_loading) {
      entity.copyWith(isLoadingMore: true);

      _loading = true;
      page = page + 1;

      await fetchCategoryNews(false, isFromLoadMore: true);
    }
  }

  void onChipSelect(Map<String, dynamic> data) {
    entity = entity.copyWith(
        selectedIndex: data['isSelected'] ? data['index'] : null);
    fetchCategoryNews(false, isFromLoadMore: false);
  }

  void onTabClicked(int index) {
    entity = entity.copyWith(selectedIndex: index);
    fetchCategoryNews(false, isFromLoadMore: false, isFromTabClicked: true);
  }

  _getSelectedCategory() {
    return entity.selectedIndex != -1
        ? NewsCategory.values[entity.selectedIndex].value
        : "";
  }

  isFromBBC(String callFrom) {
    return callFrom == 'bbc';
  }

  @override
  void dispose() {
    entity.scrollController.dispose();
    super.dispose();
  }

  onBottomTabSelect(int value) {}
}

class NewsListOutputTransformer
    extends OutputTransformer<NewsListEntity, NewsListUiOutput> {
  @override
  NewsListUiOutput transform(NewsListEntity entity) {
    return NewsListUiOutput(
        status: entity.status,
        newsList: entity.newsList,
        selectedIndex: entity.selectedIndex,
        isRefresh: entity.isRefreshed,
        bbcNewsList: entity.bbcNewsList,
        healthNewsList: entity.healthNewsList,
        scrollController: entity.scrollController,
        isLoadingMoreFailed: entity.isLoadingMore,
        currentSelectedBottomTab: entity.currentSelectedBottomTab);
  }
}
