import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/model/bookmark_data.dart';

enum RequestType { add, delete, fetch }

enum BookMarkScreenStatus { loading, initial, loaded, failed, deleted }

class BookMarkNewsEntity extends Entity {
  final Stream<List<BookMarkData>>? bookMarkList;
  final BookMarkScreenStatus status;
  final int deletedId;

  const BookMarkNewsEntity(
      {this.bookMarkList, required this.status, required this.deletedId});
  // @override
  // BookMarkNewsEntity copyWith(List<BookMarkData>? bookMarkList) {
  //   return BookMarkNewsEntity(bookMarkList: bookMarkList?? this.bookMarkList);
  // }

  @override
  BookMarkNewsEntity copyWith(
      {Stream<List<BookMarkData>>? bookMarkList,
      BookMarkScreenStatus? status,
      bool? isRefresh,
      int? deletedId}) {
    return BookMarkNewsEntity(
      bookMarkList: bookMarkList ?? this.bookMarkList,
      status: status ?? this.status,
      deletedId: deletedId ?? this.deletedId,
    );
  }

  @override
  List<Object?> get props => [bookMarkList, status, deletedId];
}
