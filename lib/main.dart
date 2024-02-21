import 'dart:io';

import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/features/bookmark_news/gateways/providers.dart';
import 'package:daily_news_app/features/bottom_navigation_ui.dart';
import 'package:daily_news_app/features/news_list/provider/news_list_external_interface_provider.dart';
import 'package:daily_news_app/features/tech_crunch/provider/providers.dart';
import 'package:flutter/material.dart';

void main() async {
  HttpOverrides.global = MyHttpOverrides();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppProviderScope(
      externalInterfaceProviders: [
        newsListExternalInterfaceProvider,
        techCrunchExternalInterfaceProvider,
        bookMarkExternalInterfaceProvider
      ],
      child: MaterialApp(
        title: 'Daily News',
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
            useMaterial3: true,
            fontFamily: 'Lato'),
        home: const BottomNavigationUI(),
        // home: NewsDetailUI(
        //   newsData: NewsData.sample(),
        // )
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
