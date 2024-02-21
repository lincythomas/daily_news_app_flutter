import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/model/bookmark_data.dart';
import 'package:daily_news_app/model/tech_data.dart';

enum Screens {
  home(0),
  techCrunch(1);

  final int tabTndex;
  const Screens(this.tabTndex);
}

enum ScreenStatus { loading, loaded, initial, failed }

class TechCrunchEntity extends Entity {
  final ScreenStatus status;
  final List<TechData> postList;
  final bool isBookMarked;
  final Stream<List<BookMarkData>>? bookMarkList;

  const TechCrunchEntity(
      {this.status = ScreenStatus.initial,
      required this.postList,
      required this.isBookMarked,
      this.bookMarkList});

  @override
  List<Object?> get props => [status, postList, isBookMarked];

  @override
  TechCrunchEntity copyWith(
      {ScreenStatus? status,
      List<TechData>? postList,
      bool? isBookMarked,
      Stream<List<BookMarkData>>? bookMarkList}) {
    return TechCrunchEntity(
        status: status ?? this.status,
        postList: postList ?? this.postList,
        isBookMarked: isBookMarked ?? this.isBookMarked,
        bookMarkList: bookMarkList ?? this.bookMarkList);
  }
}
