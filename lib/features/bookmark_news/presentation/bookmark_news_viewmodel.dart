import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/model/bookmark_data.dart';
import 'package:flutter/foundation.dart';

class BookMarkNewsViewModel extends ViewModel {
  final Stream<List<BookMarkData>>? bookMarkList;
  final VoidCallback fetchBookMark;
  final ValueChanged<BookMarkData> onDelete;

  const BookMarkNewsViewModel(
      {required this.bookMarkList,
      required this.fetchBookMark,
      required this.onDelete});
  @override
  List<Object?> get props => [bookMarkList];
}
