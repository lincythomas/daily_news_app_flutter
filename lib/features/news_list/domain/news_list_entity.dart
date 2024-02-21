import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/model/news_data.dart';
import 'package:flutter/material.dart';

const categoryTag = "CATEGORY_TAG";

enum NewsListStatus {
  loading,
  initial,
  loaded,
  failed,
  loadMoreFailed,
  tabDataLoading
}

enum NewsCategory {
  business('business'),
  entertainment('entertainment'),
  general('general'),
  health('health'),
  science('science'),
  sports('sports'),
  technology('technology');

  final String value;
  const NewsCategory(this.value);
}

class NewsListEntity extends Entity {
  final List<NewsData> newsList;
  final List<NewsData> bbcNewsList;
  final List<NewsData> healthNewsList;
  final NewsListStatus status;
  final int selectedIndex;
  final bool isRefreshed;
  final ScrollController scrollController;
  final bool isLoadingMore;
  final int currentSelectedBottomTab;

  const NewsListEntity(
      {required this.newsList,
      required this.bbcNewsList,
      required this.selectedIndex,
      required this.healthNewsList,
      this.status = NewsListStatus.initial,
      this.isRefreshed = false,
      required this.scrollController,
      required this.isLoadingMore,
      required this.currentSelectedBottomTab});

  @override
  NewsListEntity copyWith({
    List<NewsData>? newsList,
    List<NewsData>? bbcNewsList,
    List<NewsData>? healthNewsList,
    int? selectedIndex,
    NewsListStatus? status,
    bool? isRefresh,
    ScrollController? scrollController,
    bool? isLoadingMore,
    int? currentSelectedBottomTab,
  }) {
    return NewsListEntity(
        newsList: newsList ?? this.newsList,
        status: status ?? this.status,
        selectedIndex: selectedIndex ?? this.selectedIndex,
        isRefreshed: isRefresh ?? isRefreshed,
        bbcNewsList: bbcNewsList ?? this.bbcNewsList,
        healthNewsList: healthNewsList ?? this.healthNewsList,
        scrollController: scrollController ?? this.scrollController,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        currentSelectedBottomTab:
            currentSelectedBottomTab ?? this.currentSelectedBottomTab);
  }

  @override
  List<Object?> get props => [
        newsList,
        bbcNewsList,
        healthNewsList,
        status,
        selectedIndex,
        isRefreshed,
        scrollController,
        isLoadingMore,
        currentSelectedBottomTab
      ];
}
