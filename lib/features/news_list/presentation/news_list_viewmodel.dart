import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/model/news_data.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class NewsListViewModel extends ViewModel {
  final List<NewsData> newsList;
  final List<NewsData> bbcNewsList;

  final List<NewsData> healthNewsList;
  final bool isLoading;
  final bool isTabDataLoading;
  final bool hasLoadingFailed;
  final int selectedIndex;
  final ValueChanged<Map<String, dynamic>> onChipSelect;
  final ValueChanged<int> onTabClicked;
  final AsyncCallback onRefresh;
  final ScrollController scrollController;
  final bool isLoadingMore;

  final int currentSelectedBottomTab;
  final ValueChanged<int> onBottomTabSelect;

  const NewsListViewModel(
      {required this.newsList,
      required this.isLoading,
      required this.hasLoadingFailed,
      required this.selectedIndex,
      required this.onChipSelect,
      required this.onRefresh,
      required this.bbcNewsList,
      required this.onTabClicked,
      required this.healthNewsList,
      required this.scrollController,
      required this.isLoadingMore,
      required this.currentSelectedBottomTab,
      required this.onBottomTabSelect,
      required this.isTabDataLoading});

  @override
  List<Object?> get props => [
        newsList,
        isLoading,
        hasLoadingFailed,
        selectedIndex,
        isLoadingMore,
        bbcNewsList,
        currentSelectedBottomTab,
        isTabDataLoading,
      ];
}
