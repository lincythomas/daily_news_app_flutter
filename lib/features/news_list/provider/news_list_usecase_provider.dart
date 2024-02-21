import 'package:clean_framework/clean_framework.dart';
import 'package:daily_news_app/features/news_detail/domain/news_detail_usecase.dart';
import 'package:daily_news_app/features/news_list/domain/news_list_usecase.dart';

final newsListUseCaseProvider =
    UseCaseProvider.autoDispose(NewsListUseCase.new);

final newsDetailUseCaseProvider =
    UseCaseProvider.autoDispose(NewsDetailUsecase.new);
