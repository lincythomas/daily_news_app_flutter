import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/features/bookmark_news/domain/bookmark_news_entity.dart';
import 'package:daily_news_app/model/bookmark_data.dart';

class BookMarkNewsUIOutput extends Output {
  final Stream<List<BookMarkData>>? bookMarkList;
  final BookMarkScreenStatus status;

  const BookMarkNewsUIOutput({
    required this.bookMarkList,
    required this.status,
  });
  @override
  List<Object?> get props => [
        bookMarkList,
        status,
      ];
}
