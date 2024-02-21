import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/features/news_detail/domain/news_detail_entity.dart';
import 'package:daily_news_app/features/news_detail/domain/news_detail_ui_output.dart';

class NewsDetailUsecase extends UseCase<NewsDetailEntity> {
  NewsDetailUsecase()
      : super(entity: const NewsDetailEntity(), transformers: [
          OutputTransformer.from(
              (entity) => NewsDetailUIOutput(status: entity.status))
        ]);
}
