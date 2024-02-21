import 'dart:io';

import 'package:clean_framework_test/clean_framework_test.dart';
import 'package:daily_news_app/features/news_detail/presentation/news_detail.ui.dart';
import 'package:daily_news_app/features/news_detail/presentation/news_detail_viewmodel.dart';
import 'package:daily_news_app/model/news_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUpAll(() {
    HttpOverrides.global = null;
  });
  uiTest('when newsData(title, content,) is null',
      ui: NewsDetailUI(
        newsData: NewsData.isNull(),
      ),
      viewModel: const NewsDetailViewModel(isLoading: false),
      verify: (tester) async {
    await tester.pumpAndSettle();
    expect(find.text("News Detail Screen"), findsOneWidget);
    expect(find.text('No content avaialble'), findsOneWidget);
  });

  uiTest('check if image is loaded; success',
      ui: NewsDetailUI(newsData: NewsData.sample()),
      viewModel: const NewsDetailViewModel(isLoading: false),
      verify: (tester) async {
    // await mockNetworkImagesFor(() async => await tester.pump());
    await tester.pumpAndSettle();
    expect(find.byType(Image), findsOneWidget);

    // await
  });

  uiTest('description showing; success',
      ui: NewsDetailUI(newsData: NewsData.sample()),
      viewModel: const NewsDetailViewModel(isLoading: false),
      verify: (tester) async {
    await tester.pumpAndSettle();
    expect(
        find.text(
            'As Apple Vision Pro is now available in stores and has reached the hands of thousands of customers in the U.S., we’ve seen multiple hands-on and, of course, some drop tests. Although the front glass … [+1790 chars]'),
        findsOneWidget);
  });

  uiTest('if content is null, show no-content msg',
      ui: NewsDetailUI(newsData: NewsData.isNull()),
      viewModel: const NewsDetailViewModel(isLoading: false), verify: (tester) {
    expect(find.text('No content avaialble'), findsOneWidget);
  });
}
