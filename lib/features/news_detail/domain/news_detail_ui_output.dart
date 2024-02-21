import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/features/news_detail/domain/news_detail_entity.dart';

class NewsDetailUIOutput extends Output {
  final NewsDetailStatus status;

  const NewsDetailUIOutput({required this.status});
  @override
  List<Object?> get props => [status];
}
