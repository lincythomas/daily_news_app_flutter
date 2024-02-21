import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/model/tech_data.dart';
import 'package:flutter/material.dart';

class TechCrunchViewModel extends ViewModel {
  final bool isLoading;
  final bool isFetchFailed;
  final bool isLoaded;
  final bool isBookMarked;
  final List<TechData> postList;
  final ValueChanged<TechData> onBookMarkClicked;

  const TechCrunchViewModel(
      {required this.isFetchFailed,
      required this.isLoading,
      required this.isLoaded,
      required this.postList,
      required this.onBookMarkClicked,
      required this.isBookMarked});
  @override
  List<Object?> get props =>
      [isLoading, isFetchFailed, postList, isLoaded, isBookMarked];
}
