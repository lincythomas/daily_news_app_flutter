import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/features/news_list/domain/news_list_entity.dart';
import 'package:daily_news_app/model/news_data.dart';
import 'package:flutter/material.dart';

class NewsListUiOutput extends Output {
  final NewsListStatus status;
  final List<NewsData> newsList;
  final List<NewsData> bbcNewsList;

  final List<NewsData> healthNewsList;

  final bool isRefresh;
  final ScrollController scrollController;
  // final FormController formController;

  final int selectedIndex;
  final bool isLoadingMoreFailed;
  final int currentSelectedBottomTab;

  const NewsListUiOutput(
      {required this.status,
      required this.newsList,
      required this.selectedIndex,
      required this.isRefresh,
      required this.bbcNewsList,
      required this.healthNewsList,
      required this.scrollController,
      required this.isLoadingMoreFailed,
      required this.currentSelectedBottomTab});

  @override
  List<Object?> get props => [
        status,
        newsList,
        selectedIndex,
        isRefresh,
        bbcNewsList,
        healthNewsList,
        isLoadingMoreFailed,
        currentSelectedBottomTab,
      ];
}
