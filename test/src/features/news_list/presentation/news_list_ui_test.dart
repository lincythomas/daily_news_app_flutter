import 'dart:io';

import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:daily_news_app/features/news_list/presentation/news_list_ui.dart';
import 'package:daily_news_app/features/news_list/presentation/news_list_viewmodel.dart';
import 'package:daily_news_app/model/news_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() => HttpOverrides.global = null);

  final newsList = [
    NewsData(
        author: "author",
        title: "title",
        description: "description",
        source: {
          "source": "nothing",
        },
        url: "url",
        urlToImage: "urlToImage",
        publishedAt: "publishedAt",
        content: "content")
  ];
  uiTest(
    'initial setUp',
    ui: NewsListUI(),
    viewModel: NewsListViewModel(
        newsList: const [],
        hasLoadingFailed: false,
        isLoading: false,
        selectedIndex: -1,
        onChipSelect: (Map<String, dynamic> data) => {},
        onRefresh: () {
          return onFetchApi();
        }),
    verify: (tester) async {
      expect(find.text('Today\'s Top Headlines'), findsOneWidget);
    },
  );

  uiTest('is progress bar showing when isLoading is true',
      ui: NewsListUI(),
      viewModel: NewsListViewModel(
          newsList: const [],
          isLoading: true,
          hasLoadingFailed: false,
          selectedIndex: -1,
          onChipSelect: (Map<String, dynamic> data) => {},
          onRefresh: () {
            return onFetchApi();
          }), verify: (tester) async {
    // await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  uiTest('error text showing when loading failed',
      ui: NewsListUI(),
      viewModel: NewsListViewModel(
          newsList: const [],
          isLoading: false,
          hasLoadingFailed: true,
          selectedIndex: -1,
          onChipSelect: (Map<String, dynamic> data) => {},
          onRefresh: () {
            return onFetchApi();
          }), verify: (tester) async {
    expect(find.text('Something went wrong'), findsOneWidget);
  });

  uiTest('show list title when data is fetched',
      ui: NewsListUI(),
      viewModel: NewsListViewModel(
          newsList: newsList,
          isLoading: false,
          hasLoadingFailed: false,
          selectedIndex: -1,
          onChipSelect: (Map<String, dynamic> data) => {},
          onRefresh: () {
            return onFetchApi();
          }), verify: (tester) async {
    expect(find.text('title'), findsOneWidget);
  });

  uiTest(
    'is choice-chip visible',
    ui: NewsListUI(),
    viewModel: NewsListViewModel(
        newsList: newsList,
        isLoading: false,
        hasLoadingFailed: false,
        selectedIndex: -1,
        onChipSelect: (Map<String, dynamic> data) => {},
        onRefresh: () {
          return onFetchApi();
        }),
    verify: (tester) {
      expect(find.byType(ChoiceChip), findsNWidgets(7));
    },
  );
}

Future<void> onFetchApi() {
  return Future(() => null);
}
